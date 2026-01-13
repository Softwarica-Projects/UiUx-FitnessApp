<x-guest-layout>
   <section class="login-content">
      <div class="row m-0 align-items-center bg-white vh-100">
         <div class="col-md-6">
               <div class="mm-login-shapes-logo d-flex align-items-center justify-content-between">
               </div>
            <div class="row justify-content-center mb-4">
               <div class="col-md-10">
                  <div class="card card-transparent shadow-none d-flex justify-content-center mb-0 auth-card">
                     <div class="card-body">
                        <div class="auth-logo ">
                           <a href="{{route('dashboard')}}" class="navbar-brand d-flex align-items-center mb-5">
                           </a>
                        </div>
                        <h4 class="mb-4 text-right">{{ __('auth.login') }}</h4>
                        
                        <x-auth-session-status class="mb-4" :status="session('status')" />

                        
                        <x-auth-validation-errors class="mb-4" :errors="$errors" />
                        <form method="POST" action="{{ route('login') }}" data-toggle="validator">
                            {{csrf_field()}}
                           <div class="row">
                              <div class="col-lg-12">
                                 <div class="form-group">
                                    <label for="email" class="form-label">{{ __('message.email') }}</label>
                                    <input id="email" type="email" name="email"  value="{{ old('email') }}" class="form-control"  placeholder="admin@example.com" required autofocus>
                                 </div>
                              </div>
                              <div class="col-lg-12">
                                 <div class="form-group">
                                    <label for="password" class="form-label">{{ __('message.password') }}</label>
                                    <input class="form-control" type="password" placeholder="********"  name="password" value="" required autocomplete="current-password">
                                 </div>
                              </div>
                              <div class="col-lg-6">
                                 <div class="form-check mb-3">
                                    <input type="checkbox" class="form-check-input" id="customCheck1">                                    
                                    <label class="form-check-label" for="customCheck1">{{ __('auth.remember_me') }}</label>
                                 </div>
                              </div>
                              <div class="col-lg-6">
                                 <a href="{{route('password.request')}}"  class="float-end">{{ __('auth.forgot_password') }}</a>
                              </div>
                           </div>
                           <div class="d-flex justify-content-center">
                              <button type="submit" class="btn btn-primary col-lg-12">{{ __('auth.login') }}</button>
                           </div>
                        </form>
                     </div>
                  </div>
               </div>
            </div>
            <div class="sign-bg">
               
            </div>
         </div>
         <div class="col-md-6 d-md-block d-none bg-soft-warning p-0 mt-n1 vh-100 overflow-hidden">
            <img src="{{asset('images/logo.png')}}" class="img-fluid gradient-main animated-scaleX" alt="images">
         </div>
      </div>
   </section>
</x-guest-layout>
