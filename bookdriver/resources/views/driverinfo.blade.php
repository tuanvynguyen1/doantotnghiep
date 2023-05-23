@extends('layouts.user_type.auth')

@section('content')
    <div class="container-fluid my-3 py-3">
        <div class="row mb-5">
            <div class="col-lg-3">
                <div class="card position-sticky top-1">
                    <ul class="nav flex-column bg-white border-radius-lg p-3">
                        <li class="nav-item">
                            <a class="nav-link text-body" data-scroll=""
                               href="#profile">
                                <div class="icon me-2">
                                    <svg class="text-dark mb-1" width="16px" height="16px" viewBox="0 0 40 40"
                                         version="1.1" xmlns="http://www.w3.org/2000/svg"
                                         xmlns:xlink="http://www.w3.org/1999/xlink">
                                        <title>spaceship</title>
                                        <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                                            <g transform="translate(-1720.000000, -592.000000)" fill="#FFFFFF"
                                               fill-rule="nonzero">
                                                <g transform="translate(1716.000000, 291.000000)">
                                                    <g transform="translate(4.000000, 301.000000)">
                                                        <path class="color-background"
                                                              d="M39.3,0.706666667 C38.9660984,0.370464027 38.5048767,0.192278529 38.0316667,0.216666667 C14.6516667,1.43666667 6.015,22.2633333 5.93166667,22.4733333 C5.68236407,23.0926189 5.82664679,23.8009159 6.29833333,24.2733333 L15.7266667,33.7016667 C16.2013871,34.1756798 16.9140329,34.3188658 17.535,34.065 C17.7433333,33.98 38.4583333,25.2466667 39.7816667,1.97666667 C39.8087196,1.50414529 39.6335979,1.04240574 39.3,0.706666667 Z M25.69,19.0233333 C24.7367525,19.9768687 23.3029475,20.2622391 22.0572426,19.7463614 C20.8115377,19.2304837 19.9992882,18.0149658 19.9992882,16.6666667 C19.9992882,15.3183676 20.8115377,14.1028496 22.0572426,13.5869719 C23.3029475,13.0710943 24.7367525,13.3564646 25.69,14.31 C26.9912731,15.6116662 26.9912731,17.7216672 25.69,19.0233333 L25.69,19.0233333 Z"></path>
                                                        <path class="color-background"
                                                              d="M1.855,31.4066667 C3.05106558,30.2024182 4.79973884,29.7296005 6.43969145,30.1670277 C8.07964407,30.6044549 9.36054508,31.8853559 9.7979723,33.5253085 C10.2353995,35.1652612 9.76258177,36.9139344 8.55833333,38.11 C6.70666667,39.9616667 0,40 0,40 C0,40 0,33.2566667 1.855,31.4066667 Z"></path>
                                                        <path class="color-background"
                                                              d="M17.2616667,3.90166667 C12.4943643,3.07192755 7.62174065,4.61673894 4.20333333,8.04166667 C3.31200265,8.94126033 2.53706177,9.94913142 1.89666667,11.0416667 C1.5109569,11.6966059 1.61721591,12.5295394 2.155,13.0666667 L5.47,16.3833333 C8.55036617,11.4946947 12.5559074,7.25476565 17.2616667,3.90166667 L17.2616667,3.90166667 Z"
                                                              opacity="0.598539807"></path>
                                                        <path class="color-background"
                                                              d="M36.0983333,22.7383333 C36.9280725,27.5056357 35.3832611,32.3782594 31.9583333,35.7966667 C31.0587397,36.6879974 30.0508686,37.4629382 28.9583333,38.1033333 C28.3033941,38.4890431 27.4704606,38.3827841 26.9333333,37.845 L23.6166667,34.53 C28.5053053,31.4496338 32.7452344,27.4440926 36.0983333,22.7383333 L36.0983333,22.7383333 Z"
                                                              opacity="0.598539807"></path>
                                                    </g>
                                                </g>
                                            </g>
                                        </g>
                                    </svg>
                                </div>
                                <span class="text-sm">Hồ sơ</span>
                            </a>
                        </li>
                        <li class="nav-item pt-2">
                            <a class="nav-link text-body" data-scroll=""
                               href="#basic-info">
                                <div class="icon me-2">
                                    <svg class="text-dark mb-1" width="16px" height="16px" viewBox="0 0 40 44"
                                         version="1.1" xmlns="http://www.w3.org/2000/svg"
                                         xmlns:xlink="http://www.w3.org/1999/xlink">
                                        <title>document</title>
                                        <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                                            <g transform="translate(-1870.000000, -591.000000)" fill="#FFFFFF"
                                               fill-rule="nonzero">
                                                <g transform="translate(1716.000000, 291.000000)">
                                                    <g transform="translate(154.000000, 300.000000)">
                                                        <path class="color-background"
                                                              d="M40,40 L36.3636364,40 L36.3636364,3.63636364 L5.45454545,3.63636364 L5.45454545,0 L38.1818182,0 C39.1854545,0 40,0.814545455 40,1.81818182 L40,40 Z"
                                                              opacity="0.603585379"></path>
                                                        <path class="color-background"
                                                              d="M30.9090909,7.27272727 L1.81818182,7.27272727 C0.814545455,7.27272727 0,8.08727273 0,9.09090909 L0,41.8181818 C0,42.8218182 0.814545455,43.6363636 1.81818182,43.6363636 L30.9090909,43.6363636 C31.9127273,43.6363636 32.7272727,42.8218182 32.7272727,41.8181818 L32.7272727,9.09090909 C32.7272727,8.08727273 31.9127273,7.27272727 30.9090909,7.27272727 Z M18.1818182,34.5454545 L7.27272727,34.5454545 L7.27272727,30.9090909 L18.1818182,30.9090909 L18.1818182,34.5454545 Z M25.4545455,27.2727273 L7.27272727,27.2727273 L7.27272727,23.6363636 L25.4545455,23.6363636 L25.4545455,27.2727273 Z M25.4545455,20 L7.27272727,20 L7.27272727,16.3636364 L25.4545455,16.3636364 L25.4545455,20 Z"></path>
                                                    </g>
                                                </g>
                                            </g>
                                        </g>
                                    </svg>
                                </div>
                                <span class="text-sm">Thông tin cơ bản</span>
                            </a>
                        </li>
                        <li class="nav-item pt-2">
                            <a class="nav-link text-body" data-scroll=""
                               href="#sessions">
                                <div class="icon me-2">
                                    <svg class="text-dark mb-1" width="16px" height="16px" viewBox="0 0 40 40"
                                         version="1.1" xmlns="http://www.w3.org/2000/svg"
                                         xmlns:xlink="http://www.w3.org/1999/xlink">
                                        <title>settings</title>
                                        <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                                            <g transform="translate(-2020.000000, -442.000000)" fill="#FFFFFF"
                                               fill-rule="nonzero">
                                                <g transform="translate(1716.000000, 291.000000)">
                                                    <g transform="translate(304.000000, 151.000000)">
                                                        <polygon class="color-background" opacity="0.596981957"
                                                                 points="18.0883333 15.7316667 11.1783333 8.82166667 13.3333333 6.66666667 6.66666667 0 0 6.66666667 6.66666667 13.3333333 8.82166667 11.1783333 15.315 17.6716667"></polygon>
                                                        <path class="color-background"
                                                              d="M31.5666667,23.2333333 C31.0516667,23.2933333 30.53,23.3333333 30,23.3333333 C29.4916667,23.3333333 28.9866667,23.3033333 28.48,23.245 L22.4116667,30.7433333 L29.9416667,38.2733333 C32.2433333,40.575 35.9733333,40.575 38.275,38.2733333 L38.275,38.2733333 C40.5766667,35.9716667 40.5766667,32.2416667 38.275,29.94 L31.5666667,23.2333333 Z"
                                                              opacity="0.596981957"></path>
                                                        <path class="color-background"
                                                              d="M33.785,11.285 L28.715,6.215 L34.0616667,0.868333333 C32.82,0.315 31.4483333,0 30,0 C24.4766667,0 20,4.47666667 20,10 C20,10.99 20.1483333,11.9433333 20.4166667,12.8466667 L2.435,27.3966667 C0.95,28.7083333 0.0633333333,30.595 0.00333333333,32.5733333 C-0.0583333333,34.5533333 0.71,36.4916667 2.11,37.89 C3.47,39.2516667 5.27833333,40 7.20166667,40 C9.26666667,40 11.2366667,39.1133333 12.6033333,37.565 L27.1533333,19.5833333 C28.0566667,19.8516667 29.01,20 30,20 C35.5233333,20 40,15.5233333 40,10 C40,8.55166667 39.685,7.18 39.1316667,5.93666667 L33.785,11.285 Z"></path>
                                                    </g>
                                                </g>
                                            </g>
                                        </g>
                                    </svg>
                                </div>
                                <span class="text-sm">Phiên đăng nhập</span>
                            </a>
                        </li>
                        <li class="nav-item pt-2">
                            <a class="nav-link text-body" data-scroll=""
                               href="#delete">
                                <div class="icon me-2">
                                    <svg class="text-dark mb-1" width="16px" height="16px" viewBox="0 0 45 40"
                                         version="1.1" xmlns="http://www.w3.org/2000/svg"
                                         xmlns:xlink="http://www.w3.org/1999/xlink">
                                        <title>shop </title>
                                        <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                                            <g transform="translate(-1716.000000, -439.000000)" fill="#FFFFFF"
                                               fill-rule="nonzero">
                                                <g transform="translate(1716.000000, 291.000000)">
                                                    <g transform="translate(0.000000, 148.000000)">
                                                        <path class="color-background"
                                                              d="M46.7199583,10.7414583 L40.8449583,0.949791667 C40.4909749,0.360605034 39.8540131,0 39.1666667,0 L7.83333333,0 C7.1459869,0 6.50902508,0.360605034 6.15504167,0.949791667 L0.280041667,10.7414583 C0.0969176761,11.0460037 -1.23209662e-05,11.3946378 -1.23209662e-05,11.75 C-0.00758042603,16.0663731 3.48367543,19.5725301 7.80004167,19.5833333 L7.81570833,19.5833333 C9.75003686,19.5882688 11.6168794,18.8726691 13.0522917,17.5760417 C16.0171492,20.2556967 20.5292675,20.2556967 23.494125,17.5760417 C26.4604562,20.2616016 30.9794188,20.2616016 33.94575,17.5760417 C36.2421905,19.6477597 39.5441143,20.1708521 42.3684437,18.9103691 C45.1927731,17.649886 47.0084685,14.8428276 47.0000295,11.75 C47.0000295,11.3946378 46.9030823,11.0460037 46.7199583,10.7414583 Z"
                                                              opacity="0.598981585"></path>
                                                        <path class="color-foreground"
                                                              d="M39.198,22.4912623 C37.3776246,22.4928106 35.5817531,22.0149171 33.951625,21.0951667 L33.92225,21.1107282 C31.1430221,22.6838032 27.9255001,22.9318916 24.9844167,21.7998837 C24.4750389,21.605469 23.9777983,21.3722567 23.4960833,21.1018359 L23.4745417,21.1129513 C20.6961809,22.6871153 17.4786145,22.9344611 14.5386667,21.7998837 C14.029926,21.6054643 13.533337,21.3722507 13.0522917,21.1018359 C11.4250962,22.0190609 9.63246555,22.4947009 7.81570833,22.4912623 C7.16510551,22.4842162 6.51607673,22.4173045 5.875,22.2911849 L5.875,44.7220845 C5.875,45.9498589 6.7517757,46.9451667 7.83333333,46.9451667 L19.5833333,46.9451667 L19.5833333,33.6066734 L27.4166667,33.6066734 L27.4166667,46.9451667 L39.1666667,46.9451667 C40.2482243,46.9451667 41.125,45.9498589 41.125,44.7220845 L41.125,22.2822926 C40.4887822,22.4116582 39.8442868,22.4815492 39.198,22.4912623 Z"></path>
                                                    </g>
                                                </g>
                                            </g>
                                        </g>
                                    </svg>
                                </div>
                                <span class="text-sm">Kích hoạt/Hủy kích hoạt</span>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="col-lg-9 mt-lg-0 mt-4">

                <div class="card card-body" id="profile">
                    <div class="row justify-content-center align-items-center">
                        <div class="col-sm-auto col-4">

                            @if($driver->avatar == null)
                                <div class="avatar avatar-xl position-relative">
                                    <img src="{{ asset('img/avatar/default-avatar.png') }}" alt="{{ $driver->id }}"
                                         class="w-100 border-radius-lg shadow-sm">
                                </div>
                            @else
                                <div class="avatar avatar-xl position-relative">
                                    <img src="{{asset('storage'.str_replace('public','',$driver->avatar))}}" alt="{{ $driver->id }}"
                                         class="w-100 border-radius-lg shadow-sm">
                                </div>
                            @endif
                        </div>
                        <div class="col-sm-auto col-8 my-auto">
                            <div class="h-100">
                                <h5 class="mb-1 font-weight-bolder">
                                    {{ $driver->name }}
                                </h5>
                                <p class="mb-0 font-weight-bold text-sm">
                                    Tài xế
                                </p>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="card mt-4" id="basic-info">
                    <div class="card-header">
                        <h5>Thông tin cơ bản</h5>
                    </div>

                    @csrf
                    <div class="card-body pt-0">
                        <div class="row">
                            <div class="col-12">
                                <input type="hidden" id="id" value="{{ $driver->id }}">
                                <label class="form-label">Họ Tên</label>
                                <div class="input-group">
                                    <input id="name" name="name" class="form-control" type="text"
                                           placeholder="Nguyễn Văn X" value="{{ $driver->name }}" required="required"
                                           onfocus="focused(this)"
                                           onfocusout="defocused(this)">
                                </div>
                            </div>

                        </div>

                        <div class="row">
                            <div class="col-sm-6 col-6">
                                <label class="form-label mt-4">Giới tính</label>
                                <div class="form-group" tabindex="0" aria-haspopup="true" aria-expanded="false">
                                    <select id="gender" name="gender" class="form-select">
                                        <option value="1" {{ $driver->gender == true ? 'selected' : '' }}>Nam
                                        </option>
                                        <option value="0" {{ $driver->gender == false ? 'selected' : '' }}>Nữ
                                        </option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="row">
                                    <div class="col-sm-3 col-5">
                                        <label class="form-label mt-4">Ngày sinh</label>
                                        <div class="form-group" data-type="select-one" tabindex="0" role="combobox"
                                             aria-autocomplete="list" aria-haspopup="true" aria-expanded="false">
                                            <select name="date" id="date" class="form-select">
                                                @for($i = 1; $i<32; $i++)
                                                    <option
                                                        value="{{ $i }}" {{ $i == date('d', strtotime($driver->dob)) ?'Selected' : '' }}> {{$i}} </option>
                                                @endfor
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-sm-4 col-3">
                                        <label class="form-label mt-4">&nbsp;</label>
                                        <div class="form-group" data-type="select-one" tabindex="0" role="combobox"
                                             aria-autocomplete="list" aria-haspopup="true" aria-expanded="false">
                                            <select name="month" id="month" class="form-select">
                                                @for($i = 1; $i<=12; $i++)
                                                    <option
                                                        value="{{ $i }}" {{ $i == date('m', strtotime($driver->dob)) ?'Selected' : '' }}>
                                                        Tháng {{ $i }}</option>
                                                @endfor
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-sm-3 col-4">
                                        <label class="form-label mt-4">&nbsp;</label>
                                        <div class="form-group" data-type="select-one" tabindex="0" role="combobox"
                                             aria-autocomplete="list" aria-haspopup="true" aria-expanded="false">
                                            <select name="year" id="year" class="form-select">
                                                @for($i = 1900; $i<now()->year; $i++)
                                                    <option
                                                        value="{{$i}}" {{ $i == date('Y', strtotime($driver->dob)) ?'Selected' : '' }}> {{ $i }}</option>
                                                @endfor
                                            </select>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-6">
                                <label class="form-label mt-4">Email</label>
                                <div class="input-group">
                                    <input id="email" name="email" class="form-control" type="email"
                                           placeholder="example@email.com" value="{{ $driver->email }}"
                                           onfocus="focused(this)"
                                           onfocusout="defocused(this)">
                                </div>
                            </div>
                            <div class="col-6">
                                <label class="form-label mt-4">CMND/CCCD</label>
                                <div class="input-group">
                                    <input id="cccd" name="cccd" class="form-control"
                                           placeholder="19xxxxxxx" value="{{ $driver->citizen_identity_card }}"
                                           onfocus="focused(this)"
                                           onfocusout="defocused(this)">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-6">
                                <label class="form-label mt-4">Địa chỉ</label>
                                <div class="input-group">
                                    <input id="location" name="location" class="form-control" type="text"
                                           placeholder="xx Hà Nội, TP Huế" value="{{ $driver->address }}"
                                           onfocus="focused(this)" onfocusout="defocused(this)">
                                </div>
                            </div>
                            <div class="col-6">
                                <label class="form-label mt-4">Số điện thoại</label>
                                <div class="input-group">
                                    <input id="phone" name="phone" class="form-control" type="number"
                                           placeholder="03x xxx xxxx" value="{{ $driver->phone }}">
                                </div>
                            </div>
                        </div>
                        <div class="d-sm-flex pt-0 mt-4">
                            <button class="btn bg-gradient-success mb-0 ms-auto" id="updateInfo" type="submit"
                                    name="button">Cập
                                nhật
                            </button>
                        </div>

                    </div>
                </div>

                <div class="card mt-4" id="sessions">
                    <div class="card-header pb-3">
                        <h5>CMND/CCCD</h5>
                    </div>
                    <div class="card-body pt-0">
                        <div class="row">
                            <div class="col-6">
                                <a href="{{asset('storage'.str_replace('public','',$driver->citizen_identity_card_img_front))}}"
                                   data-lightbox="image-1" data-title="My caption">
                                    <img
                                        src="{{asset('storage'.str_replace('public','',$driver->citizen_identity_card_img_front))}}"
                                        height="300px">
                                </a>

                            </div>
                            <div class="col-6">
                                <a href="{{asset('storage'.str_replace('public','',$driver->citizen_identity_card_img_back))}}"
                                   data-lightbox="image-1" data-title="My caption">
                                    <img
                                        src="{{asset('storage'.str_replace('public','',$driver->citizen_identity_card_img_back))}}"
                                        height="300px">
                                </a>
                            </div>

                        </div>
                    </div>
                </div>
                <div class="card mt-4" id="driverlicense">
                    <div class="card-header pb-3">
                        <h5>Giấy phép điều khiển phương tiện</h5>
                    </div>
                    <div class="card-body pt-0">
                        <div class="row">
                            @foreach($driver->driverLicense as $item)
                                <p style="font-weight: bold">Giấy phép loại: {{ $item->rank }}</p>

                            <div class="col-6">
                                <a href="{{asset('storage'.str_replace('public','',$item->front))}}"
                                   data-lightbox="license-{{ $item->id }}" data-title="My caption">
                                    <img
                                        src="{{asset('storage'.str_replace('public','',$item->front))}}"
                                        height="300px">
                                </a>

                            </div>
                            <div class="col-6">
                                <a href="{{asset('storage'.str_replace('public','',$item->back))}}"
                                   data-lightbox="license-{{ $item->id }}" data-title="My caption">
                                    <img
                                        src="{{asset('storage'.str_replace('public','',$item->back))}}"
                                        height="300px">
                                </a>
                            </div>
                                @if($item->status == 0)
                                    <div class="d-sm-flex pt-0 mt-4">
                                        <button class="btn bg-gradient-danger mb-0 ms-auto" onclick=""  type="submit"
                                                name="button">Từ chối
                                        </button>
                                        <button class="btn bg-gradient-success mb-0 " style="margin-left: 10px;" onclick="" type="submit"
                                                name="button">Chấp nhận
                                        </button>

                                    </div>
                                @endif
                            @endforeach
                        </div>
                    </div>
                </div>
                <div class="card mt-4" id="sessions">
                    <div class="card-header pb-3">
                        <h5>Sessions</h5>
                        <p class="text-sm">Kiểm tra các phiên đăng nhập của người dùng! </p>
                    </div>
                    <div class="card-body pt-0">
                        @foreach($session as $item)
                            <div class="d-flex align-items-center">
                                <div class="text-center w-5">
                                    <i class="fas fa-desktop text-lg opacity-6" aria-hidden="true"></i>
                                </div>
                                <div class="my-auto ms-3">
                                    <div class="h-100">
                                        <p class="text-sm mb-1">
                                            {{$item->device_name}}
                                        </p>

                                    </div>
                                </div>
                                <span class="badge badge-success badge-sm my-auto ms-auto me-3">Còn hạn</span>
                                <p class="text-secondary text-sm my-auto me-3">SEA</p>
                            </div>
                            <hr class="horizontal dark">
                        @endforeach
                    </div>
                </div>

                <div class="card mt-4" id="active">
                    @if($driver->is_active == 0)
                        <div class="card-header">
                            <h5>Kích hoạt</h5>
                            <p class="text-sm mb-0">Chấp nhận thông tin người dùng cung cấp và kích hoạt tài khoản cho
                                người dùng.</p>
                        </div>
                        <div class="card-body ">

                            <div class="d-sm-flex pt-0">
                                <button class="btn bg-gradient-success mb-0 ms-auto" id="switchActive" type="submit"
                                        name="button">Kích
                                    hoạt
                                </button>
                            </div>

                        </div>

                    @else
                        <div class="card-header">
                            <h5>Hủy Kích hoạt</h5>
                            <p class="text-sm mb-0">Hủy kích hoạt với người dùng. Trong trường hợp vi phạm chính
                                sách...</p>
                        </div>
                        <div class="card-body ">

                            <div class="d-sm-flex pt-0">
                                <button class="btn bg-gradient-faded-white-vertical mb-0 ms-auto" id="switchActive"
                                        type="submit"
                                        name="button">Hủy kích hoạt
                                </button>
                            </div>

                        </div>
                    @endif
                </div>
            </div>
        </div>
    </div>
    <div class="ps__rail-x" style="left: 0px; bottom: 0px;">
        <div class="ps__thumb-x" tabindex="0" style="left: 0px; width: 0px;"></div>
    </div>
    <div class="ps__rail-y" style="top: 0px; height: 764px; right: 0px;">
        <div class="ps__thumb-y" tabindex="0" style="top: 0px; height: 162px;"></div>
    </div>
    <link href="{{ asset('lib/lightbox/dist/css/lightbox.min.css') }}" rel="stylesheet"/>
    <!-- As A Vanilla JavaScript Plugin -->
    <script src="{{ asset('lib/lightbox/dist/js/lightbox-plus-jquery.min.js') }}"></script>

    <script>

        $(document).ready(function () {

        });

        function convertDate(date, month, year) {
            var d = new Date(month + '-' + date + '-' + year);
            if (d.getMonth() + 1 != month || d.getDate() != date || d.getFullYear() != year) {
                return NaN;

            }
            return d;
        }

        $('#updateInfo').on('click', function () {

            var id = $('#id').val();
            var name = $('#name').val();
            var gender = $('#gender').val();
            var email = $('#email').val();
            var cccd = $('#cccd').val();
            var location = $('#location').val();
            var phone = $('#phone').val()
            var date = convertDate($('#date').val(), $('#month').val(), $('#year').val());
            if (isNaN(date)) {
                toastr.error('Ngày tháng đang bị lỗi!', 'Lỗi ngày tháng')
            }


            $.ajax({
                headers: {
                    'X-CSRF-TOKEN': $('meta[name="_token"]').attr('content')
                },
                url: '{{ URL::to('drivers/update') }}',
                type: 'POST',
                dataType: 'json',
                data: {
                    'id': id,
                    'name': name,
                    'email': email,
                    'dob': date.toLocaleDateString("en-US"),
                    'gender': gender,
                    'phone': phone,
                    'address': location,
                    'citizen_identity_card': cccd,
                }
            }).done(function (data) {
                if (data.msg != null)
                    toastr.success(data.msg, 'Cập nhật thành công.')
                else {
                    toastr.error(data.error, 'Lỗi');
                }
            })
        });

        $('#switchActive').on('click', function () {

            var id = $('#id').val();
            $.ajax({
                headers: {
                    'X-CSRF-TOKEN': $('meta[name="_token"]').attr('content')
                },
                url: '{{ URL::to('drivers/switchStatus') }}',
                type: 'POST',
                dataType: 'json',
                data: {
                    'id': id
                }
            }).done(function (data) {
                if (data.msg != null) {
                    toastr.success(data.msg, 'Thay đổi thành công.');
                    setTimeout(() => {
                        window.location.reload();
                    }, 2000);
                } else {
                    toastr.error(data.error, 'Lỗi');
                }
            })

        });

        function acceptLicense(id){
            $.ajax({
                headers: {
                    'X-CSRF-TOKEN': $('meta[name="_token"]').attr('content')
                },
                url: '{{ URL::to('drivers/acceptLicense') }}',
                type: 'POST',
                dataType: 'json',
                data: {
                    'id': id
                }
            }).done(function (data) {
                if (data.msg != null) {
                    toastr.success(data.msg, 'Xác minh bằng lái thành công.');
                    setTimeout(() => {
                        window.location.reload();
                    }, 2000);
                } else {
                    toastr.error(data.error, 'Lỗi');
                }
            })
        }
    </script>
@endsection

