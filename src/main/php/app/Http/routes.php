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

Route::get('/', function()
{
    return view('index');
});

Route::post('/', 'ReactionController@getReactions');

Route::get('/{drug}', [
  'as'   => 'listReactions',
  'uses' => 'ReactionController@listReactions'
]);

Route::get('/{drug}/{reaction}', [
  'as'   => 'listInteractions',
  'uses' => 'ReactionController@listInteractions'
]);