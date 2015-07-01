<?php

if ( ! function_exists('format_title'))
{
	/**
	 * Assign high numeric IDs to a config item to force appending.
	 *
	 * @param  array  $array
	 * @return array
	 */
	function format_title($string)
	{
		return ucwords(strtolower($string));
	}
}

if ( ! function_exists('format_get'))
{
	/**
	 * Assign high numeric IDs to a config item to force appending.
	 *
	 * @param  array  $array
	 * @return array
	 */
	function format_get($string)
	{
		return str_replace(['%2F', '%22'], ['%252F'], rawurlencode(trim($string)));
	}
}