<?php
defined('IN_LitePhp') or exit('Access Denied');

use App\admin\auth;

function auth_node_href(int|string $authId): string
{
    return auth::instance()->nodeHref($authId);
}

function auth_node_auth(int|array|string $authId, bool $tag = false): bool
{
    return auth::instance()->authNode($authId, $tag);
}