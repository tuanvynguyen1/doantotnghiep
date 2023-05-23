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
                                    <h6>Tài khoản tài xế</h6>
                                </div>
                                @if($isPending == false)
                                <div class="col-2">
                                    <a href="drivers/pending"><button class="btn btn-outline-primary btn-sm mb-0">Hồ sơ mới</button></a>
                                </div>
                                @endif
                            </div>
                        </div>
                        <div class="card-body px-0 pt-0 pb-2">
                            <div class="table-responsive p-0 ">
                                <table id="datatable" class="table table-flush" >
                                    <thead class="thead-light">
                                    <tr>
                                        <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">
                                            Tài xế
                                        </th>
                                        <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">
                                            Đánh giá
                                        </th>
                                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">
                                            Trạng thái
                                        </th>
                                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">
                                            Ngày đăng ký
                                        </th>
                                        <th class="text-secondary opacity-7"></th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    @foreach ($drivers as $driver)
                                        <tr>
                                            <td>
                                                <div class="d-flex px-2 py-1">
                                                    <div>
                                                        @if($driver->avatar == null)
                                                        <img src="{{ asset('img/avatar/default-avatar.png') }}" class="avatar avatar-sm me-3"
                                                             alt="user1">
                                                        @else
                                                            <img src="{{asset('storage'.$driver->avatar)}}" class="avatar avatar-sm me-3"
                                                                 alt="user1">
                                                        @endif
                                                    </div>
                                                    <div class="d-flex flex-column justify-content-center">
                                                        <h6 class="mb-0 text-sm">{{ $driver->name }}</h6>
                                                        <p class="text-xs text-secondary mb-0">{{ $driver->email }}</p>
                                                    </div>
                                                </div>
                                            </td>
                                            <td>
                                                <div id="rate"></div>
                                            </td>
                                            <td class="align-middle text-center text-sm">
                                                <span class="badge badge-sm {{ $driver->is_online==true?'bg-gradient-success':'bg-gradient-warning' }}">{{ $driver->is_online==true?'Online':'Offline' }}</span>
                                            </td>
                                            <td class="align-middle text-center">
                                                <span class="text-secondary text-xs font-weight-bold">{{ $driver->created_at }}</span>
                                            </td>
                                            <td class="align-middle">
                                                <a href="/drivers/{{ $driver->id }}" class="text-secondary font-weight-bold text-xs"
                                                   data-toggle="tooltip" data-original-title="Edit user">
                                                    Xem Thông Tin
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

    </script>

@endsection
