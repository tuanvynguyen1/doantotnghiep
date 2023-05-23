@extends('layouts.user_type.auth')

@section('content')

    <main class="main-content position-relative max-height-vh-100 h-100 mt-1 border-radius-lg ">
        <div class="container-fluid py-4">
            <div class="row">
                <div class="col-12">

                    <div class="card mb-4">

                        <div class="card-header pb-0">
                            <div class="row">
                                <div class="col-2">
                                    <h6>Bản đồ Trực Tuyến</h6>
                                </div>
                            </div>
                        </div>
                        <div class="card-body px-0 pt-0 pb-2" style="height: 30rem;">
                            <div id="map" style="width:100%;height:32rem; border-radius: 0px 0px 20px 20px;"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>
    <script src="https://code.jquery.com/jquery-3.6.4.js"
            integrity="sha256-a9jBBRygX1Bh5lt8GZjXDzyOB+bWve9EiO7tROUtj/E=" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.4/css/jquery.dataTables.css" />
    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/rateYo/2.3.2/jquery.rateyo.min.css">
    <!-- Latest compiled and minified JavaScript -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/rateYo/2.3.2/jquery.rateyo.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.js"></script>
    <link rel="stylesheet" href="{{ asset('lib/leaflet/leaflet.css') }}" />
    <script src="{{ asset('lib/leaflet/leaflet.js') }}"></script>

    <script type="text/javascript">
        var markers = {};
        var map;
        var curlat = 15.9804019;
        var curlong = 108.2733526;
        var carIcon = L.icon({
            iconUrl: '{{ asset('img/icon/car.png') }}',

            iconSize:     [20, 40], // size of the icon
            shadowAnchor: [4, 62]// point from which the popup should open relative to the iconAnchor
        });
        $(document).ready(()=>{
            if( navigator.geolocation )
            {
                // Call getCurrentPosition with success and failure callbacks
                navigator.geolocation.getCurrentPosition( success, fail );
            }
            else
            {
                alert("Sorry, your browser does not support geolocation services.");
            }

            retriveMarker();

        })
        function success(position)
        {
            curlong = position.coords.longitude;
            curlat = position.coords.latitude;
            initMap()

        }

        function fail()
        {
            // Could not obtain location
            initMap()
        }


        function initMap(){
            map = L.map('map').setView([curlat, curlong], 18);
            L.tileLayer('http://{s}.google.com/vt/lyrs=p&x={x}&y={y}&z={z}',{
                maxZoom: 20,
                subdomains:['mt0','mt1','mt2','mt3']
            }).addTo(map);
        }
        function popupContent(id, name, phone, status, avatar){
            var html = '<div class="row" style="width: 300px;">'+
                '<div class="col-sm-4 d-flex justify-content-center">'+
                '<img src="https://www.w3schools.com/howto/img_avatar2.png" style="vertical-align: middle;width: 50px;height: 50px;border-radius: 50%;"/>'+
                '</div>'+
            '<div class="col-sm-8">'+
                '<p style="font-weight: bold;margin: 0;">'+name+'</p>'+
            '</div>'+
            '<div class="col-sm-4 d-flex justify-content-end">'+
                '<p style="font-weight: bold;margin: 0;">SDT:</p>'+
            '</div>'+
            '<div class="col-sm-8 d-flex justify-content-start">'+
                '<p style="margin: 0;">'+phone+'</p>'+
            '</div>'+
            '<div class="col-sm-4 d-flex justify-content-end">'+
                '<p style="font-weight: bold;margin: 0;">Status:</p>'+
            '</div>'+
            '<div class="col-sm-8 d-flex justify-content-start">'+
                '<p style="margin: 0;">'+(status === 1?"Đang chở khách":"Đang rãnh tay")+'</p>'+
            '</div>'+
                '<div class="col-sm-12"><a href={{ URL::to('drivers') }}/'+id+'><button class="btn bg-gradient-success mb-0" style="width:100%;">Xem thông tin</button></a></div>'
        '</div>'
            return html;
        }
        function retriveMarker(){
            $.ajax({
                headers: {
                    'X-CSRF-TOKEN': $('meta[name="_token"]').attr('content')
                },
                url: '{{ URL::to('drivers/getLocation') }}',
                type: 'POST',
                dataType: 'json',
            }).done(function(data){
                if(data.status === "Success") {

                    data.data.forEach(function(item, index){
                        if(item.is_online === 1 && markers[item.id] == null){
                            markers[item.id] = L.marker(
                                [item.lat, item.long],
                                {
                                    icon: carIcon
                                }
                            ).addTo(map).bindPopup(popupContent(item.id,item.name, item.phone, item.status, ""));
                        }
                        else if(item.is_online == 1){
                            markers[item.id].setLatLng([item.lat, item.long]);
                        }

                    });
                }
                else{
                    toastr.error(data.error,'Lỗi');
                }

                setTimeout(function(){retriveMarker();}, 5000);
            })
        }
    </script>


@endsection
