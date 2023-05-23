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
                                    <h6>Danh sách Booking</h6>
                                </div>

                            </div>
                        </div>
                        <div class="card-body px-0 pt-0 pb-2">
                            <div class="table-responsive p-0">
                                <table id="datatable" class=" align-items-center mb-0  ">
                                    <thead>
                                    <tr>
                                        <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">
                                            Tên tài xế
                                        </th>
                                        <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">
                                            Tên khách hàng
                                        </th>
                                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">
                                            Trạng thái
                                        </th>
                                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">
                                            Xuất phát
                                        </th>
                                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">
                                            Điểm đến
                                        </th>
                                        <th class="text-secondary opacity-7"></th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    @foreach ($booking as $item)
                                        <tr>
                                            <td class="text-sm">
                                                <span class="mb-0 text-sm">{{ $item->Driver != null ? $item->Driver->name : "" }}</span>
                                            </td>
                                            <td>
                                                <span class="mb-0 text-sm">{{ $item->UserInfo->name }}</span>
                                            </td>
                                            <td class="text-sm">
                                                <span class="mb-0 text-sm">{{ $item->paymentstatus == 0? "Chưa thanh toán": "Đã thanh toán" }}</span>
                                            </td>
                                            <td class="">
                                                {{ $item->addressfrom }}
                                            </td>
                                            <td class="">
                                                {{ $item->addressdes }}
                                            </td>
                                            <td class="align-middle">
                                                <a href="{{ URL::to('booking/route').'/'.$item->id }}" class="text-secondary font-weight-bold text-xs"
                                                   data-toggle="tooltip" data-original-title="Edit user">
                                                    Bản đồ
                                                </a>
                                            </td>
                                        </tr>
                                    @endforeach
                                    </tbody>
                                </table>
                            </div>
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
    <script>

        $(document).ready(function () {
            $('#datatable').dataTable({
                "bInfo": false,
                "bLengthChange": false,
                "ordering": false,
                language: {
                    paginate: {
                        next: '&#8594;', // or '→'
                        previous: '&#8592;' // or '←'
                    }
                }
            })
        });

    </script>

@endsection
