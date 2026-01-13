<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Support\Facades\Auth;
use App\Models\Role;

class UserActive
{
    public function handle($request, Closure $next)
    {   
        $user = auth()->user();
        if (Auth::check() && $user->status == 'active' ) {
            $role = Role::whereIn('name',$user->getRoleNames())->where('status',1)->first();
            if($role == null) {
                abort(403, __('message.contact_sytem_admin'));
            }
            return $next($request);
        } else {
            Auth::logout();
            abort(403, __('message.access_denied'));
        }
    }
}
