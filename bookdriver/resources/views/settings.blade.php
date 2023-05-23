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
                                    <h6>Cài đặt</h6>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card mt-4" id="sessions">
                    <div class="card-header pb-3">
                        <h5>Banner Quảng cáo</h5>
                    </div>
                    <div class="card-body pt-0">
                        <div class="table-responsive p-0 ">
                            <table id="datatable" class="table table-flush" >
                                <thead class="thead-light">
                                <tr>
                                    <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">
                                        Tên
                                    </th>
                                    <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">
                                        Hình ảnh
                                    </th>
                                    <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">
                                        Ngày hết hạn
                                    </th>
                                    <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">
                                        Thao tác
                                    </th>
                                </tr>
                                </thead>
                                <tbody>
                                @foreach ($banner as $item)
                                    <tr>
                                        <td class="align-middle text-center">
                                            <span>{{ $item->name }}</span>
                                        </td>
                                        <td class="align-middle text-center">
                                            <a href="{{asset('storage'.$item->image)}}"
                                               data-lightbox="banner">
                                                <img src="{{asset('storage'.$item->image)}}" height="50">
                                            </a>
                                        </td>
                                        <td class="align-middle text-center text-sm">
                                            <span class="text-secondary text-xs font-weight-bold">{{ date('d-m-Y', strtotime($item->expire)) }}</span>
                                        </td>

                                        <td class="align-middle">
                                            <a href="#" class="text-secondary font-weight-bold text-xs">
                                                <button class="btn btn-danger" onclick="removeBanner({{ $item->id }})"> Xóa </button>
                                            </a>
                                        </td>
                                    </tr>
                                @endforeach
                                </tbody>

                            </table>
                            <div class="d-sm-flex pt-0">
                                <button class="btn bg-gradient-success mb-0 ms-auto" id="addBanner" data-toggle="modal" data-target="#exampleModal"
                                        name="button">Thêm mới
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">Thêm Banner mới</h5>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <label for="name">Tên banner: </label>
                                <input type="text" class="form-control" id="name" placeholder="Nhập tên banner">
                            </div>
                            <div class="form-group" >
                                <label>Chọn ngày tới hạn: </label>
                                <input type="date" id="expire" class="form-control">
                            </div>
                            <div class="form-group">
                                <label for="image">Thêm file hình ảnh:</label>
                                <div class="upload-upbtn-wrapper">
                                    <input type="file"  id="actual-btn" accept="image/*" hidden/>

                                    <!-- our custom upload button -->
                                    <label class="chosse" for="actual-btn">Choose File</label>

                                    <!-- name of file chosen -->
                                    <span id="file-chosen">No file chosen</span>
                                </div>
                                <div id="dvPreview"></div>
                            </div>

                        </div>
                        <div class="modal-footer">
                            <button type="button" id="submitBanner" class="btn btn-primary">Lưu</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </main>
    <link href="{{ asset('lib/lightbox/dist/css/lightbox.min.css') }}" rel="stylesheet"/>
    <!-- As A Vanilla JavaScript Plugin -->
    <script src="{{ asset('lib/lightbox/dist/js/lightbox-plus-jquery.min.js') }}"></script>
    <script src="https://code.jquery.com/jquery-3.6.4.js"
            integrity="sha256-a9jBBRygX1Bh5lt8GZjXDzyOB+bWve9EiO7tROUtj/E=" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.4/css/jquery.dataTables.css" />
    <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.js"></script>

    <script>

        $(document).ready(function () {
            $('#datatable').dataTable({
                "bInfo": false,
                "bLengthChange": false,
                language: {
                    paginate: {
                        next: '&#8594;', // or '→'
                        previous: '&#8592;' // or '←'
                    }
                }
            })





        });
        function formatDate(date){
            let part = date.split('-');
            return part[2] + '/' + part[1] + '/' + part[0]
        }
        $('#addBanner').on('click', function(){
            $('.modal').modal('show')
        });

        const actualBtn = document.getElementById('actual-btn');

        const fileChosen = document.getElementById('file-chosen');

        actualBtn.addEventListener('change', function(){
            removeUploadData();
            fileChosen.textContent = this.files[0].name;
            if (typeof (FileReader) != "undefined") {
                var dvPreview = $("[id*=dvPreview]");
                var regex = /^([a-zA-Z0-9ÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯĂẠẢẤẦẨẪẬẮẰẲẴẶẸẺẼỀỀỂẾưăạảấầẩẫậắằẳẵặẹẻẽềềểếỄỆỈỊỌỎỐỒỔỖỘỚỜỞỠỢỤỦỨỪễệỉịọỏốồổỗộớờởỡợụủứừỬỮỰỲỴÝỶỸửữựỳỵỷỹ\s\W|_])+(.jpg|.jpeg|.png)$/;
                $($(this)[0].files).each(function () {
                    var file = $(this);
                    if (regex.test(file[0].name.toLowerCase())) {
                        var reader = new FileReader();
                        reader.onload = function (e) {
                            var img = $("<img id='prevIMG'/>");
                            img.attr("style", "max-height:250px;width: 150px");
                            img.attr("src", e.target.result);
                            var div = $("<div style='float:left;' />");
                            $(div).html("<span style='float:right;' class='closeDiv'>X<span>");
                            div.append(img);

                            dvPreview.append(div);
                        }
                        reader.readAsDataURL(file[0]);
                    } else {
                        alert(file[0].name + " is not a valid image file.");
                        removeUploadData();
                        return false;
                    }
                });
            } else {
                alert("This browser does not support HTML5 FileReader.");
            }


        })
        $('#submitBanner').on('click', function(){
            var name = $('#name').val()
            var expire = $('#expire').val()
            var image = $('#actual-btn')[0].files[0]
            var form = new FormData();
            form.append('name', name)
            form.append('expire', expire)
            form.append('image', image)

            $.ajax({
                headers: {
                    'X-CSRF-TOKEN': $('meta[name="_token"]').attr('content')
                },
                url: '{{ URL::to('banner/add') }}',
                type: 'POST',
                cache: false,
                contentType: false,
                processData: false,
                dataType: 'json',
                data: form
            }).done(function (data) {
                if(data.status === 'Success'){
                    toastr.success(data.msg, 'Thêm mới thành công.')
                    setTimeout(() => {
                        window.location.reload();
                    }, 2000);
                }
                else{
                    toastr.error(data.msg, 'Lỗi');
                }
            })
        });
        function removeBanner(id){
            $.ajax({
                headers: {
                    'X-CSRF-TOKEN': $('meta[name="_token"]').attr('content')
                },
                url: '{{ URL::to('banner/remove') }}',
                type: 'POST',
                dataType: 'json',
                data: {
                    'id' : id
                }
            }).done(function (data) {
                if(data.status === 'Success'){
                    toastr.success(data.msg, 'Xóa thành công.')
                    setTimeout(() => {
                        window.location.reload();
                    }, 2000);
                }
                else{
                    toastr.error(data.msg, 'Lỗi');
                }
            })
        }
        function removeUploadData(){
            $('.closeDiv').closest('div').remove();
            $('#file-chosen').text('No file chosen');
            $('#actual-btn').value  = "";
        }

        $('body').on('click', '.closeDiv', function () {
            removeUploadData();
        });
    </script>

@endsection
