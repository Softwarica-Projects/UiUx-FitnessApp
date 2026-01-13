<?php

namespace App\View\Components;

use Illuminate\View\Component;

class HeaderBreadcrumb extends Component
{
    public $class , $role;

    public function __construct($class='' , $role='')
    {
        $this -> class = $class;
        $this -> role = $role;
    }

    public function render()
    {
        return view('components.header-breadcrumb');
    }
}
