@php
    $url = '';
    
    $MyNavBar = \Menu::make('MenuList', function ($menu) use($url){
        
        //Admin Dashboard
        $menu->add('<span class="item-name">'.__('message.dashboard').'</span>', ['route' => 'dashboard'])
            ->link->attr([ 'class' => activeRoute(route('dashboard')) ? 'nav-link active' : 'nav-link' ]);
            
        $menu->add('<span class="item-name">'.__('message.user').'</span>', ['class' => ''])
            ->nickname('user')
            ->data('permission', 'user-list')
            ->link->attr(['class' => 'nav-link' ])
            ->href('#user');

            $menu->user->add('<span class="item-name">'.__('message.list_form_title',['form' => __('message.user')]).'</span>', ['route' => 'users.index'])
                ->data('permission', 'user-list')
                ->link->attr(['class' => activeRoute(route('users.index')) ? 'nav-link active' : 'nav-link']);

            $menu->user->add('<span class="item-name">'.__('message.add_form_title',['form' => __('message.user')]).'</span>', ['route' => 'users.create'])
                ->data('permission', [ 'user-add', 'user-edit'])
                ->link->attr(['class' => activeRoute(route('users.create')) || request()->is('users/*/edit') ? 'nav-link active' : 'nav-link']);

        $menu->add('<span class="item-name">'.__('message.sub_admin').'</span>', ['class' => ''])
            ->nickname('sub_admin')
            ->data('permission', 'subadmin-list')
            ->link->attr(['class' => 'nav-link' ])
            ->href('#sub_admin');

            $menu->sub_admin->add('<span class="item-name">'.__('message.list_form_title',['form' => __('message.sub_admin')]).'</span>', ['route' => 'subadmin.index'])
                ->data('permission', 'subadmin-list')
               ->link->attr(['class' => activeRoute(route('subadmin.index')) ? 'nav-link active' : 'nav-link']);

            $menu->sub_admin->add('<span class="item-name">'.__('message.add_form_title',['form' => __('message.sub_admin')]).'</span>', ['route' => 'subadmin.create'])
                ->data('permission', [ 'subadmin-add', 'subadmin-edit'])
                ->link->attr(['class' => activeRoute(route('subadmin.create')) || request()->is('subadmin/*/edit') ? 'nav-link active' : 'nav-link']);

        $menu->add('<span class="item-name">'.__('message.equipment').'</span>', ['class' => ''])
            ->nickname('equipment')
            ->data('permission', 'equipment-list')
            ->link->attr(['class' => 'nav-link' ])
            ->href('#equipment');

            $menu->equipment->add('<span class="item-name">'.__('message.list_form_title',['form' => __('message.equipment')]).'</span>', ['route' => 'equipment.index'])
                ->data('permission', 'equipment-list')
                ->link->attr(['class' => activeRoute(route('equipment.index')) ? 'nav-link active' : 'nav-link']);

            $menu->equipment->add('<span class="item-name">'.__('message.add_form_title',['form' => __('message.equipment')]).'</span>', ['route' => 'equipment.create'])
                ->data('permission', [ 'equipment-add', 'equipment-edit'])
                ->link->attr(['class' => activeRoute(route('equipment.create')) || request()->is('equipment/*/edit') ? 'nav-link active' : 'nav-link']);

        $menu->add('<span class="item-name">'.__('message.exercise').'</span>', ['class' => ''])
           ->nickname('exercise')
            ->data('permission', 'exercise-list')
            ->link->attr(['class' => 'nav-link' ])
            ->href('#exercise');

            $menu->exercise->add('<span class="item-name">'.__('message.list_form_title',['form' => __('message.exercise')]).'</span>', ['route' => 'exercise.index'])
                ->data('permission', 'exercise-list')
                ->link->attr(['class' => activeRoute(route('exercise.index')) ? 'nav-link active' : 'nav-link']);

            $menu->exercise->add('<span class="item-name">'.__('message.add_form_title',['form' => __('message.exercise')]).'</span>', ['route' => 'exercise.create'])
                ->data('permission', [ 'exercise-add', 'exercise-edit'])
                ->link->attr(['class' => activeRoute(route('exercise.create')) || request()->is('exercise/*/edit') ? 'nav-link active' : 'nav-link']);
        
        $menu->add('<span class="item-name">'.__('message.workout').'</span>', ['class' => ''])
            ->nickname('workout')
            ->data('permission', 'workout-list')
            ->link->attr(['class' => 'nav-link' ])
            ->href('#workout');

            $menu->workout->add('<span class="item-name">'.__('message.list_form_title',['form' => __('message.workout')]).'</span>', ['route' => 'workout.index'])
                ->data('permission', 'workout-list')
                ->link->attr(['class' => activeRoute(route('workout.index')) ? 'nav-link active' : 'nav-link']);

            $menu->workout->add('<span class="item-name">'.__('message.add_form_title',['form' => __('message.workout')]).'</span>', ['route' => 'workout.create'])
                ->data('permission', [ 'workout-add', 'workout-edit'])
                ->link->attr(['class' => activeRoute(route('workout.create')) || request()->is('workout/*/edit') ? 'nav-link active' : 'nav-link']);
            
            $menu->workout->add('<span class="item-name">'.__('message.list_form_title',['form' => __('message.workouttype')]).'</span>', ['route' => 'workouttype.index'])
                ->data('permission', 'workouttype-list')
                ->link->attr(['class' => activeRoute(route('workouttype.index')) ? 'nav-link active' : 'nav-link']);

        $menu->add('<span class="item-name">'.__('message.diet').'</span>', ['class' => ''])
             ->nickname('diet')
            ->data('permission', 'diet-list')
            ->link->attr(['class' => 'nav-link' ])
            ->href('#diet');

            $menu->diet->add('<span class="item-name">'.__('message.list_form_title',['form' => __('message.diet')]).'</span>', ['route' => 'diet.index'])
                ->data('permission', 'diet-list')
                ->link->attr(['class' => activeRoute(route('diet.index')) ? 'nav-link active' : 'nav-link']);

            $menu->diet->add('<span class="item-name">'.__('message.add_form_title',['form' => __('message.diet')]).'</span>', ['route' => 'diet.create'])
                ->data('permission', [ 'diet-add', 'diet-edit'])
                ->link->attr(['class' => activeRoute(route('diet.create')) || request()->is('diet/*/edit') ? 'nav-link active' : 'nav-link']);
            
            $menu->diet->add('<span class="item-name">'.__('message.list_form_title',['form' => __('message.categorydiet')]).'</span>', ['route' => 'categorydiet.index'])
                ->data('permission', 'categorydiet-list')
                ->link->attr(['class' => activeRoute(route('categorydiet.index')) ? 'nav-link active' : 'nav-link']);
    
        $menu->add('<span class="item-name">'.__('message.level').'</span>', ['class' => ''])
             ->nickname('level')
            ->data('permission', 'level-list')
            ->link->attr(['class' => 'nav-link' ])
            ->href('#level');

            $menu->level->add('<span class="item-name">'.__('message.list_form_title',['form' => __('message.level')]).'</span>', ['route' => 'level.index'])
                ->data('permission', 'level-list')
                ->link->attr(['class' => activeRoute(route('level.index')) ? 'nav-link active' : 'nav-link']);

            $menu->level->add('<span class="item-name">'.__('message.add_form_title',['form' => __('message.level')]).'</span>', ['route' => 'level.create'])
                ->data('permission', [ 'level-add', 'level-edit'])
               ->link->attr(['class' => activeRoute(route('level.create')) || request()->is('level/*/edit') ? 'nav-link active' : 'nav-link']);

        $menu->add('<span class="item-name">'.__('message.bodypart').'</span>', ['class' => ''])
                ->nickname('bodypart')
                ->data('permission', 'bodyparts-list')
                ->link->attr(['class' => 'nav-link' ])
                ->href('#bodypart');

            $menu->bodypart->add('<span class="item-name">'.__('message.list_form_title',['form' => __('message.bodypart')]).'</span>', ['route' => 'bodypart.index'])
                ->data('permission', 'bodyparts-list')
                ->link->attr(['class' => activeRoute(route('bodypart.index')) ? 'nav-link active' : 'nav-link']);

            $menu->bodypart->add('<span class="item-name">'.__('message.add_form_title',['form' => __('message.bodypart')]).'</span>', ['route' => 'bodypart.create'])
                ->data('permission', [ 'bodyparts-add', 'bodyparts-edit'])
                ->link->attr(['class' => activeRoute(route('bodypart.create')) || request()->is('bodypart/*/edit') ? 'nav-link active' : 'nav-link']);
                
        $menu->add('<span class="item-name">'.__('message.class_schedule').'</span>', ['class' => ''])
                ->nickname('class_schedule')
                ->data('permission', 'class-schedule-list')
                ->link->attr(['class' => 'nav-link' ])
                ->href('#class_schedule');

            $menu->class_schedule->add('<span class="item-name">'.__('message.list_form_title',['form' => __('message.class_schedule')]).'</span>', ['route' => 'classschedule.index'])
                ->data('permission', 'class-schedule-list')
                ->link->attr(['class' => activeRoute(route('classschedule.index')) ? 'nav-link active' : 'nav-link']);

            $menu->class_schedule->add('<span class="item-name">'.__('message.add_form_title',['form' => __('message.class_schedule')]).'</span>', ['route' => 'classschedule.create'])
                ->data('permission', [ 'class-schedule-add', 'class-schedule-edit'])
                ->link->attr(['class' => activeRoute(route('classschedule.create')) || request()->is('classschedule/*/edit') ? 'nav-link active' : 'nav-link']);

        $menu->add('<span>'.__('message.pages').'</span>', ['class' => ''])
             ->nickname('pages')
            ->data('permission', ['terms-condition','privacy-policy'])
            ->link->attr(['class' => 'nav-link' ])
            ->href('#pages');

            if(Module::has('Frontend') && Module::isEnabled('Frontend')) {
                $menu->pages->add('<span>'.__('frontend::message.list').'</span>', ['route' => 'pages.index'])
                    ->data('permission', 'page-list')
                    ->link->attr(['class' => activeRoute(route('pages.index')) ? 'nav-link active' : 'nav-link']);
            }

            $menu->pages->add('<span>'.__('message.terms_condition').'</span>', ['route' => 'pages.term_condition'])
                ->data('permission', 'terms-condition')
               ->link->attr(['class' => activeRoute(route('pages.term_condition')) ? 'nav-link active' : 'nav-link']);

            $menu->pages->add('<span>'.__('message.privacy_policy').'</span>', ['route' => 'pages.privacy_policy'])
                ->data('permission', 'privacy-policy')
                ->link->attr(['class' => activeRoute(route('pages.privacy_policy')) ? 'nav-link active' : 'nav-link']);

        $menu->add('<span class="item-name">'.__('message.pushnotification').'</span>', ['class' => ''])
            ->nickname('pushnotification')
            ->data('permission', 'pushnotification-list')
            ->link->attr(['class' => 'nav-link' ])
            ->href('#pushnotification');

            $menu->pushnotification->add('<span class="item-name">'.__('message.list_form_title',['form' => __('message.pushnotification')]).'</span>', ['route' => 'pushnotification.index'])
                ->data('permission', 'pushnotification-list')
                ->link->attr(['class' => activeRoute(route('pushnotification.index')) ? 'nav-link active' : 'nav-link']);

            $menu->pushnotification->add('<span class="item-name">'.__('message.add_form_title',['form' => __('message.pushnotification')]).'</span>', ['route' => 'pushnotification.create'])
                ->data('permission', 'pushnotification-add')
                ->link->attr(['class' => activeRoute(route('pushnotification.create')) ? 'nav-link active' : 'nav-link']);
                
        $menu->add('<span class="item-name">'.__('message.setting').'</span>', ['route' => 'setting.index'])
            ->link->attr([ 'class' => activeRoute(route('setting.index')) ? 'nav-link active' : 'nav-link' ]);

    if(Module::has('Frontend') && Module::isEnabled('Frontend')){
        $menu->add('<span class="item-name">'.__('frontend::message.website_section').'</span>', ['class' => ''])
             ->nickname('website_section')
            ->data('permission', 'website-section-list')
            ->link->attr(['class' => 'nav-link' ])
            ->href('#website_section');

            $menu->website_section->add('<span class="item-name">'.__('message.information').'</span>', ['route' => ['frontend.website.form', 'app-info']])
            ->data('permission', 'website-section-list')
            ->link->attr(['class' => activeRoute(route('frontend.website.form', 'app-info')) ? 'nav-link active' : 'nav-link']);

            $menu->website_section->add('<span class="item-name">'.__('frontend::message.ultimate_workout').'</span>', ['route' => ['frontend.website.form', 'ultimate-workout']])
            ->data('permission', 'website-section-list')
            ->link->attr(['class' => activeRoute(route('frontend.website.form', 'ultimate-workout')) ? 'nav-link active' : 'nav-link']);

            $menu->website_section->add('<span class="item-name">'.__('frontend::message.nutrition').'</span>', ['route' => ['frontend.website.form', 'nutrition']])
            ->data('permission', 'website-section-list')
            ->link->attr(['class' => activeRoute(route('frontend.website.form', 'nutrition')) ? 'nav-link active' : 'nav-link']);

            $menu->website_section->add('<span class="item-name">'.__('frontend::message.fitness_product').'</span>', ['route' => ['frontend.website.form', 'fitness-product']])
            ->data('permission', 'website-section-list')
            ->link->attr(['class' => activeRoute(route('frontend.website.form', 'fitness-product')) ? 'nav-link active' : 'nav-link']);

            $menu->website_section->add('<span class="item-name">'.__('frontend::message.fitness_blog').'</span>', ['route' => ['frontend.website.form', 'fitness-blog']])
            ->data('permission', 'website-section-list')
            ->link->attr(['class' => activeRoute(route('frontend.website.form', 'fitness-blog')) ? 'nav-link active' : 'nav-link']);

            $menu->website_section->add('<span class="item-name">'.__('frontend::message.download_app').'</span>', ['route' => ['frontend.website.form', 'download-app']])
            ->data('permission', 'website-section-list')
            ->link->attr(['class' => activeRoute(route('frontend.website.form', 'download-app')) ? 'nav-link active' : 'nav-link']);

            $menu->website_section->add('<span class="item-name">'.__('frontend::message.client_testimonial').'</span>', ['route' => ['frontend.website.form', 'client-testimonial']])
            ->data('permission', 'website-section-list')
           ->link->attr(['class' => activeRoute(route('frontend.website.form', 'client-testimonial')) ? 'nav-link active' : 'nav-link']);

            $menu->website_section->add('<span class="item-name">'.__('frontend::message.newsletter').'</span>', ['route' => ['frontend.website.form', 'newsletter']])
            ->data('permission', 'website-section-list')
            ->link->attr(['class' => activeRoute(route('frontend.website.form', 'newsletter')) ? 'nav-link active' : 'nav-link']);

            $menu->website_section->add('<span class="item-name">'.__('frontend::message.walkthrough').'</span>', ['route' => ['frontend.website.form', 'walkthrough']])
            ->data('permission', 'website-section-list')
           ->link->attr(['class' => activeRoute(route('frontend.website.form', 'walkthrough')) ? 'nav-link active' : 'nav-link']);
        }

    })->filter(function ($item) {
        return checkMenuRoleAndPermission($item);
    });
@endphp
<ul class="navbar-nav iq-main-menu"  id="sidebar">
   
    
    <li><hr class="hr-horizontal"></li>
    
    @include(config('laravel-menu.views.bootstrap-items'), ['items' => $MyNavBar->roots()])
</ul>
