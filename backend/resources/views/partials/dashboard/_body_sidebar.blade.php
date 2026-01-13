<aside class="sidebar sidebar-default navs-rounded-all">
    <div class="sidebar-header d-flex align-items-center justify-content-start">
        <a href="{{route('dashboard')}}" class="navbar-brand">
            <div class="logo-main">
                <img class="logo-normal img-fluid site_logo_preview" src="{{ getSingleMedia(appSettingData('get'),'site_logo',null) }}" height="100" alt="site_logo">
            </div>
        </a>
    </div>
    <div class="sidebar-body pt-0 data-scrollbar pb-5">
        <div class="sidebar-list" id="sidebar">
        @include('partials.dashboard.vertical-nav') 
        </div>
    </div>
    <div class="sidebar-footer"></div>
</aside>