<?php

namespace App\View\Components;

use Illuminate\View\Component;

class BreadCrumb extends Component
{
    public $title, $classname;

    public function __construct($title = 'Title', $classname = '')
    {
        $this->title = $title;
        $this->classname = $classname;
    }

    public function render()
    {
        return view('components.bread-crumb');
    }
}
