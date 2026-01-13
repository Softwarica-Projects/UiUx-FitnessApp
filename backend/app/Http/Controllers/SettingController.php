<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Setting;
use App\Models\User;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Artisan;
use App\Helpers\EnvChange;

class SettingController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth');

    }

    public function settings(Request $request)
    {
        $auth_user = auth()->user();
        
        $pageTitle = __('message.setting');
        $page = $request->page;
      
        if($page == ''){
            if($auth_user->hasAnyRole(['admin'])){
                $page = 'mail-setting';
            }else{
                $page = 'profile-form';
            }
        }

        return view('setting.index',compact('page', 'pageTitle' ,'auth_user'));
    }

    public function layoutPage(Request $request)
    {
        $page = $request->page;
        $auth_user = auth()->user();
        $user_id = $auth_user->id;
        $settings = (object) config('app-settings');
        $user_data = User::find($user_id);
        $envSettting = $envSettting_value = [];
               
        if(count($envSettting) > 0 ){
            $envSettting_value = Setting::whereIn('key',array_keys($envSettting))->get();
        }
        
        if($user_data == null){
            $user_data = new User;
        }
        switch ($page) {
            case 'password-form':
                $data  = view('setting.'.$page, compact('settings','user_data','page'))->render();
                break;
            case 'profile-form':
                $assets = ['phone'];
                $data  = view('setting.'.$page, compact('settings','user_data','page', 'assets'))->render();
                break;
            case 'mail-setting':
                $data  = view('setting.'.$page, compact('settings','page'))->render();
                break;
            default:
                $data  = view('setting.'.$page, compact('settings','page'))->render();
                break;
        }
        return response()->json($data);
    }

    public function settingUpdate(Request $request)
    {
        $data = $request->all();
        
        foreach($data['key'] as $key => $val){
            $value = ( $data['value'][$key] != null) ? $data['value'][$key] : null;
            $input = [
                'type' => $data['type'][$key],
                'key' => $data['key'][$key],
                'value' => ( $data['value'][$key] != null) ? $data['value'][$key] : null,
            ];
            Setting::updateOrCreate(['key'=>$input['key']],$input);
            EnvChange::envChanges($data['key'][$key],$value);
        }
        return redirect()->route('setting.index', ['page' => 'mobile-config'])->withSuccess( __('message.updated'));
    }
    
    public function settingsUpdates(Request $request)
    {
        $page = $request->page;
        $env = $request->env;

        $env['APP_NAME'] = $request->site_name ?? config('app-settings.site_name');
        
        foreach ($env as $key => $value){
            EnvChange::envChanges($key, $value);
        }
        return redirect()->route('setting.index', ['page' => $page])->withSuccess( __('message.updated'));
    }
    
    public function envChanges(Request $request)
    {
        try {
            $page = $request->page;
        
        if(!auth()->user()->hasRole('admin')) {
            abort(403, __('message.action_is_unauthorized'));
        }
        $env = $request->ENV;
        $envtype = $request->type;

        foreach ($env as $key => $value){
            EnvChange::envChanges($key, str_replace('#','',$value));
        }
        Artisan::call('cache:clear');
        return redirect()->route('setting.index', ['page' => $page])->withSuccess(ucfirst($envtype).' '.__('message.updated'));
    
        } catch (\Exception $e) {
                  return redirect()->route('setting.index', ['page' => $page])->withSuccess(ucfirst($envtype).' '.__('message.updated'));

        }
       }

    public function updateProfile(Request $request)
    {
        $user = Auth::user();
        $data = $request->all();

        $user_id = $user->id;
        $validator = Validator::make($data,[
            'username' => 'required|unique:users,username,'.$user_id,
            'email' => 'required|max:191|email|unique:users,email,'.$user_id,
            'phone_number' => 'nullable|max:20|unique:users,phone_number,'.$user_id,
        ]);
        
        if($validator->fails()) {
            return redirect()->route('setting.index', ['page' => 'profile-form'])->with('errors', $validator->errors());
        }
        $user->fill($data)->update();
        storeMediaFile($user, $request->profile_image, 'profile_image');

        return redirect()->route('setting.index', ['page' => 'profile-form'])->withSuccess( __('message.profile').' '.__('message.updated'));
    }

    public function changePassword(Request $request)
    {
        $user = User::where('id',Auth::user()->id)->first();

        if($user == "") {
            $message = __('message.not_found_entry',[ 'name' => __('message.user') ]);
            return json_message_response($message,400);   
        }
        
        $validator= Validator::make($request->all(), [
            'old' => 'required|min:8|max:255',
            'password' => 'required|min:8|confirmed|max:255',
        ]);

        if ($validator->fails()) {
            return redirect()->route('setting.index', ['page' => 'password-form'])->with('errors',$validator->errors());
        }
           
        $hashedPassword = $user->password;

        $match = Hash::check($request->old, $hashedPassword);

        $same_exits = Hash::check($request->password, $hashedPassword);
        if ($match)
        {
            if($same_exits){
                $message = __('message.old_new_pass_same');
                return redirect()->route('setting.index', ['page' => 'password-form'])->with('error',$message);
            }

			$user->fill([
                'password' => Hash::make($request->password)
            ])->save();
            Auth::logout();
            $message = __('message.password_change');
            return redirect()->route('setting.index', ['page' => 'password-form'])->withSuccess($message);
        }
        else
        {
            $message = __('message.valid_password');
            return redirect()->route('setting.index', ['page' => 'password-form'])->with('error',$message);
        }
    }
    
    public function termAndCondition(Request $request)
    {
        $setting_data = Setting::where('type','terms_condition')->where('key','terms_condition')->first();
        $pageTitle = __('message.terms_condition');
        $assets = ['textarea'];
        return view('setting.term-condition-form',compact('setting_data', 'pageTitle', 'assets'));
    }

    public function saveTermAndCondition(Request $request)
    {
        $setting_data = [
                        'type'  => 'terms_condition',
                        'key'   =>  'terms_condition',
                        'value' =>  $request->value 
                    ];
        $result = Setting::updateOrCreate(['id' => $request->id],$setting_data);
        if($result->wasRecentlyCreated)
        {
            $message = __('message.save_form',['form' => __('message.terms_condition')]);
        }else{
            $message = __('message.update_form',['form' => __('message.terms_condition')]);
        }

        return redirect()->route('pages.term_condition')->withsuccess($message);
    }

    public function privacyPolicy(Request $request)
    {
        $setting_data = Setting::where('type','privacy_policy')->where('key','privacy_policy')->first();
        $pageTitle = __('message.privacy_policy');
        $assets = ['textarea'];

        return view('setting.privacy-policy-form',compact('setting_data', 'pageTitle', 'assets'));
    }

    public function savePrivacyPolicy(Request $request)
    {
        $setting_data = [
                        'type'   => 'privacy_policy',
                        'key'   =>  'privacy_policy',
                        'value' =>  $request->value 
                    ];
        $result = Setting::updateOrCreate(['id' => $request->id],$setting_data);
        if($result->wasRecentlyCreated)
        {
            $message = __('message.save_form',['form' => __('message.privacy_policy')]);
        }else{
            $message = __('message.update_form',['form' => __('message.privacy_policy')]);
        }

        return redirect()->route('pages.privacy_policy')->withsuccess($message);
    }
}
 