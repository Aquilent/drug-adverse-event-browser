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