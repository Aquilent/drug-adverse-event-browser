<?php

/*
|--------------------------------------------------------------------------
| Application Routes
|--------------------------------------------------------------------------
|
| Here is where you can register all of the routes for an application.
| It's a breeze. Simply tell Laravel the URIs it should respond to
| and give it the controller to call when that URI is requested.
|
*/

// Route::get('/', 'WelcomeController@index');

// Route::get('home', 'HomeController@index');

// Route::controllers([
// 	'auth' => 'Auth\AuthController',
// 	'password' => 'Auth\PasswordController',
// ]);

Route::get('/', function()
{
    return view('index');
});

Route::get('instructions', function()
{
    return view('instructions');
});

Route::get('disclaimers', function()
{
    return view('disclaimers');
});

Route::get('interactions', function()
{
    return view('interactions');
});

Route::get('outcomes', function()
{
    return view('outcomes');
});
