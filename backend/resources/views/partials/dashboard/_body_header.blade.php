@push('scripts')
  <script>
      $(document).ready(function() {
          const savedTheme = localStorage.getItem('theme');
          if (savedTheme) {
              if (savedTheme === 'dark') {
                  $('body').addClass('dark');
                  $('.sit_darkcolor_theam').hide();
                  $('.sit_lightcolor_theam').show();
              } else if(savedTheme === 'light'){
                  $('body').removeClass('dark');
                  $('.sit_darkcolor_theam').show();
                  $('.sit_lightcolor_theam').hide();
              }
          }
          $(".sit_color_theam").click(function() {
              let selectedMode = $(this).data("value");
              if (selectedMode === "dark") {
                  $('body').addClass('dark');
                  $('.sit_darkcolor_theam').hide();
                  $('.sit_lightcolor_theam').show();
                  localStorage.setItem('theme', 'dark');
              } else if(selectedMode === 'light') {
                  $('body').removeClass('dark');
                  $('.sit_darkcolor_theam').show();
                  $('.sit_lightcolor_theam').hide();
                  localStorage.setItem('theme', 'light');
              }
          });
      });
  </script>
@endpush
<nav class="nav navbar navbar-expand-lg navbar-light iq-navbar">
  <div class="container-fluid navbar-inner">
       <a href="{{route('dashboard')}}" class="navbar-brand">
            <div class="logo-main">
                <div class="logo-normal">
					          <img class="site_logo_preview" src="{{ getSingleMedia(appSettingData('get'), 'site_logo',null) }}" height="100" alt="site_logo">
                </div>
            </div>
      </a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      
      <span class="navbar-toggler-icon">
        <span class="navbar-toggler-bar bar1 mt-2"></span>
        <span class="navbar-toggler-bar bar2"></span>
        <span class="navbar-toggler-bar bar3"></span>
      </span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav ms-auto  navbar-list mb-2 mb-lg-0">
        <li class="nav-item dropdown">
          <a class="nav-link py-0 d-flex align-items-center" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
          <img src="{{ getSingleMedia(auth()->user(),'profile_image', null) }}" alt="User-Profile" class="img-fluid avatar avatar-50 avatar-rounded">
            <div class="caption ms-3 d-none d-md-block ">
              <h6 class="mb-0 caption-title">{{ auth()->user()->display_name }}</h6>
            </div>
          </a>
          <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
            <li><a class="dropdown-item" href="{{ route('setting.index',[ 'page' => 'profile-form' ]) }}">{{ __('message.profile') }}</a></li>
            <li><a class="dropdown-item" href="{{ route('setting.index',[ 'page' => 'password-form' ]) }}">{{ __('message.change_password') }}</a></li>
            <li><a class="dropdown-item" href="{{ route('setting.index') }}">{{ __('message.setting') }}</a></li>
            <li><hr class="dropdown-divider"></li>
            <li><form method="POST" action="{{route('logout')}}">
              @csrf
              <a href="javascript:void(0)" class="dropdown-item"
                onclick="event.preventDefault();
              this.closest('form').submit();">
                  {{ __('message.logout') }}
              </a>
              </form>
            </li>
          </ul>
        </li>
      </ul>
    </div>
  </div>
</nav>


