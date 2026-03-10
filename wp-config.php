<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the installation.
 * You don't have to use the web site, you can copy this file to "wp-config.php"
 * and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * Database settings
 * * Secret keys
 * * Database table prefix
 * * Localized language
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** Database settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress' );

/** Database username */
define( 'DB_USER', 'wpadmin' );

/** Database password */
define( 'DB_PASSWORD', 'wppassword' );

/** Database hostname */
define( 'DB_HOST', 'db' );

/** Database charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The database collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication unique keys and salts.
 *
 * Change these to different unique phrases! You can generate these using
 * the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}.
 *
 * You can change these at any point in time to invalidate all existing cookies.
 * This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',          '#z]Z;]OoNE9(CUP Zs!CwOE[rbh=)Fl6>#:0R&D#0Z%xD%!QyP] G@9iYb*dFb*x' );
define( 'SECURE_AUTH_KEY',   'B9>iKe5ca;?|e@(i`]3/Yogp~=5SQv,2,UKz9=KGk yZNpY.PapZJBcBWK5~-hA|' );
define( 'LOGGED_IN_KEY',     'TTA.]7Ds9I}ryp.dp9x:!mlMX|cMq8|AhWtMUwV(ro:A3}mUmFKW{^y|}OTe~9MB' );
define( 'NONCE_KEY',         'W 8XN4{Gq#Z4L!uPdrD0N^hz><g%-ov9AylO1nr6*K%X_jzD4jd6=xwA4*NG?mw]' );
define( 'AUTH_SALT',         '3q!`TCkD.X2|53?(p4QvcMaw+Z@k|BdV}=fa?SW(i+YQ,t PT|vEcvozfO2M)yJd' );
define( 'SECURE_AUTH_SALT',  'qjzz.X-@De[Z>N&x/H#Oh~x]n8hb}pU5qZ,^kF5>lROp<_=Qor8OTTFjabF_ZJVY' );
define( 'LOGGED_IN_SALT',    'F;<]}h7;}XOZURx`_^tY&]rHsC9%*ZC]DJH<@!`6LNWm<h2C7n&4~~Go.oec*>(g' );
define( 'NONCE_SALT',        '1m}&sF6s^`TwUDKc{:jyLpM}fLCh7SkJ5-W#*.VdjRJ%,PUN4DTkCJ&u,(Vern7f' );
define( 'WP_CACHE_KEY_SALT', 'eUKNA@n`u6p@p~(08h}h+~|J.G2BmCV=.e56O1y7jno:GlGh})<4XRF6|E2<J{vS' );


/**#@-*/

/**
 * WordPress database table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';


/* Add any custom values between this line and the "stop editing" line. */



/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
if ( ! defined( 'WP_DEBUG' ) ) {
	define( 'WP_DEBUG', false );
}

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
