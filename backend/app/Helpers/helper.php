<?php

use Illuminate\Support\Facades\Session;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Auth;
use App\Models\LanguageVersionDetail;
use App\Models\Setting;
use App\Models\Screen;
use App\Models\DefaultKeyword;
use App\Models\LanguageList;
use App\Models\LanguageWithKeyword;

function removeSession($session)
{
    if (Session::has($session)) {
        Session::forget($session);
    }
    return true;
}

function appSettingData($type = 'get')
{
    return (object) config('app-settings');
}

function randomString($length, $type = 'token')
{
    if ($type == 'password')
        $chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()_-=+;:,.?";
    elseif ($type == 'username')
        $chars = "abcdefghijklmnopqrstuvwxyz0123456789";
    else
        $chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    $token = substr(str_shuffle($chars), 0, $length);
    return $token;
}

function activeRoute($route, $isClass = false): string
{
    $requestUrl = request()->fullUrl() === $route ? true : false;

    if ($isClass) {
        return $requestUrl ? $isClass : '';
    } else {
        return $requestUrl ? 'active' : '';
    }
}

function checkMenuRoleAndPermission($menu)
{
    if (auth()->check()) {
        if ($menu->data('role') == null && auth()->user()->hasRole('admin')) {
            return true;
        }

        if ($menu->data('permission') == null && $menu->data('role') == null) {
            return true;
        }

        if ($menu->data('role') != null) {
            if (auth()->user()->hasAnyRole(explode(',', $menu->data('role')))) {
                return true;
            }
        }

        if ($menu->data('permission') != null) {
            if (is_array($menu->data('permission'))) {
                foreach ($menu->data('permission') as $permission) {
                    if (auth()->user()->can($permission)) {
                        return true;
                    }
                }
            } else {
                if (auth()->user()->can($menu->data('permission'))) {
                    return true;
                }
            }
        }
    }
    return false;
}

function checkRecordExist($table_list, $column_name, $id)
{
    if (count($table_list) > 0) {
        foreach ($table_list as $table) {
            $check_data = \DB::table($table)->where($column_name, $id)->count();
            if ($check_data > 0) return false;
        }
        return true;
    }
    return true;
}

// Model file save to storage by spatie media library
function storeMediaFile($model, $file, $name)
{
    if ($file) {
        $model->clearMediaCollection($name);
        if (is_array($file)) {
            foreach ($file as $key => $value) {
                $model->addMedia($value)->toMediaCollection($name);
            }
        } else {
            $model->addMedia($file)->toMediaCollection($name);
        }
    }
    return true;
}

// Model file get by storage by spatie media library
function getSingleMedia($model, $collection = 'image_icon', $skip = true)
{
    if (!Auth::check() && $skip) {
        return asset('images/avatars/01.png');
    } else {
        switch ($collection) {
            case 'image_icon':
                $media = asset('images/avatars/01.png');
                break;
            case 'profile_image':
                $media = asset('images/avatars/01.png');
                break;
            case 'site_favicon':
                $media = asset('images/logo.ico');
                break;
            case 'site_logo':
            case 'site_dark_logo':
            case 'site_mini_logo':
            case 'site_dark_mini_logo':
                $media = asset('images/logo.png');
                break;
            default:
                if ($model !== null) {
                    $media = $model->getFirstMedia($collection);
                }
                $imgurl = isset($media) ? $media->getPath() : '';
                if (file_exists($imgurl)) {
                    return $media->getFullUrl();
                }
                $media = asset('images/default.png');
                break;
        }
        return $media;
    }
}

// File exist check
function getFileExistsCheck($media)
{
    $mediaCondition = false;
    if ($media) {
        if ($media->disk == 'public') {
            $mediaCondition = file_exists($media->getPath());
        } else {
            $mediaCondition = Storage::disk($media->disk)->exists($media->getPath());
        }
    }
    return $mediaCondition;
}

function getMediaFileExit($model, $collection = 'profile_image')
{
    if ($model == null) {
        return asset('images/avatars/01.png');
    }

    $media = $model->getFirstMedia($collection);

    return getFileExistsCheck($media);
}

function json_message_response($message, $status_code = 200)
{
    return response()->json(['message' => $message], $status_code);
}

function json_custom_response($response, $status_code = 200)
{
    return response()->json($response, $status_code);
}

function json_pagination_response($items)
{
    return [
        'total_items'   => $items->total(),
        'per_page'      => $items->perPage(),
        'currentPage'   => $items->currentPage(),
        'totalPages'    => $items->lastPage()
    ];
}


function languagesArray($ids = [])
{
    $language = [['title' => 'English', 'id' => 'en']];

    if (!empty($ids)) {
        $language = collect($language)->whereIn('id', $ids)->values();
    }

    return $language;
}

function SettingData($type, $key = null)
{
    $setting = Setting::where('type', $type);

    $setting->when($key != null, function ($q) use ($key) {
        return $q->where('key', $key);
    });

    if ($key != null) {
        $setting_data = $setting->pluck('value')->first();
    } else {
        $setting_data = $setting->get();
    }
    return $setting_data;
}
function getPriceFormat($price)
{
    if (gettype($price) == 'string') {
        return $price;
    }
    if ($price === null) {
        $price = 0;
    }

    $currency_code = SettingData('CURRENCY', 'CURRENCY_CODE') ?? 'USD';
    $currecy = currencyArray($currency_code);

    $code = $currecy['symbol'] ?? '$';
    $position = SettingData('CURRENCY', 'CURRENCY_POSITION') ?? 'left';

    if ($position == 'left') {
        $price = $code . "" . number_format((float) $price, 2, '.', '');
    } else {
        $price = number_format((float) $price, 2, '.', '') . "" . $code;
    }

    return $price;
}
function imageExtention($media)
{
    $extention = null;
    if ($media != null) {
        $path_info = pathinfo($media);
        $extention = $path_info['extension'];
    }
    return $extention;
}

function currencyArray($code = null)
{
    $currency = [        ['code' => 'USD', 'name' => 'United States (US) dollar', 'symbol' => '$'] ];

    if ($code != null) {
        $currency = collect($currency)->where('code', $code)->first();
    }
    return $currency;
}

function stringLong($str = '', $type = 'title', $length = 0) //Add … if string is too long
{
    if ($length != 0) {
        return strlen($str) > $length ? mb_substr($str, 0, $length) . "..." : $str;
    }
    if ($type == 'desc') {
        return strlen($str) > 150 ? mb_substr($str, 0, 150) . "..." : $str;
    } elseif ($type == 'title') {
        return strlen($str) > 15 ? mb_substr($str, 0, 25) . "..." : $str;
    } else {
        return $str;
    }
}
function language_direction($language = null)
{
    if (empty($language)) {
        $language = app()->getLocale();
    }
    $language = strtolower(substr($language, 0, 2));
    return 'ltr';
}

function timeAgoFormate($date)
{
    if ($date == null) {
        return '-';
    }

    date_default_timezone_set('UTC');

    $diff_time = \Carbon\Carbon::createFromTimeStamp(strtotime($date))->diffForHumans();

    return $diff_time;
}

function timeZoneList()
{
    $list = \DateTimeZone::listAbbreviations();
    $idents = \DateTimeZone::listIdentifiers();

    $data = $offset = $added = array();
    foreach ($list as $abbr => $info) {
        foreach ($info as $zone) {
            if (!empty($zone['timezone_id']) and !in_array($zone['timezone_id'], $added) and in_array($zone['timezone_id'], $idents)) {

                $z = new \DateTimeZone($zone['timezone_id']);
                $c = new \DateTime(null, $z);
                $zone['time'] = $c->format('H:i a');
                $offset[] = $zone['offset'] = $z->getOffset($c);
                $data[] = $zone;
                $added[] = $zone['timezone_id'];
            }
        }
    }

    array_multisort($offset, SORT_ASC, $data);
    $options = array();
    foreach ($data as $key => $row) {
        $options[$row['timezone_id']] = $row['time'] . ' - ' . formatOffset($row['offset'])  . ' ' . $row['timezone_id'];
    }
    return $options;
}

function formatOffset($offset)
{
    $hours = $offset / 3600;
    $remainder = $offset % 3600;
    $sign = $hours > 0 ? '+' : '-';
    $hour = (int) abs($hours);
    $minutes = (int) abs($remainder / 60);

    if ($hour == 0 and $minutes == 0) {
        $sign = ' ';
    }
    return 'GMT' . $sign . str_pad($hour, 2, '0', STR_PAD_LEFT) . ':' . str_pad($minutes, 2, '0');
}

function dateAgoFormate($date, $type2 = '')
{
    if ($date == null || $date == '0000-00-00 00:00:00') {
        return '-';
    }

    $diff_time1 = \Carbon\Carbon::createFromTimeStamp(strtotime($date))->diffForHumans();
    $datetime = new \DateTime($date);
    $la_time = new \DateTimeZone(auth()->check() ? auth()->user()->timezone ?? 'UTC' : 'UTC');
    $datetime->setTimezone($la_time);
    $diff_date = $datetime->format('Y-m-d H:i:s');

    $diff_time = \Carbon\Carbon::parse($diff_date)->isoFormat('LLL');

    if ($type2 != '') {
        return $diff_time;
    }

    return $diff_time1 . ' on ' . $diff_time;
}

function maskedEmail($email)
{
    // return preg_replace('/^(\w{2}).*(@.*)$/', '$1**$2', $email);
    return substr($email, 0, 1) . str_repeat('*', strpos($email, '@') - 1) . strstr($email, '@');
}

function maskedPhoneNumber($phone_number)
{
    if (strlen($phone_number) >= 4) {
        // Get the first two digits and the last two digits
        $prefix = substr($phone_number, 0, 2);
        $suffix = substr($phone_number, -2);

        // Mask all characters between the first two digits and the last two digits with asterisks
        $masked = $prefix . str_repeat('*', strlen($phone_number) - 4) . $suffix;
        return $masked;
    }
    return $phone_number;
}
