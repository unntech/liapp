<?php

namespace App\admin;

/**
 * 通用的树型类
 */
class Tree extends \LiPhp\Tree
{
    /**
     * 树型结构Option
     * @param int    $myid        表示获得这个ID下的所有子级
     * @param string $itemtpl     条目模板 如："<option value=@id @selected @disabled>@spacer@name</option>"
     * @param mixed  $selectedids 被选中的ID，比如在做树型下拉框的时候需要用到
     * @param mixed  $disabledids 被禁用的ID，比如在做树型下拉框的时候需要用到
     * @param string $itemprefix  每一项前缀
     * @param string $toptpl      顶级栏目的模板
     * @return string
     */
    public function getTree($myid, $itemtpl = "<option value=@id @selected @disabled>@spacer@name</option>", $selectedids = '', $disabledids = '', $itemprefix = '', $toptpl = '')
    {
        $ret = '';
        $number = 1;
        $childs = $this->getChild($myid);
        if ($childs) {
            $total = count($childs);
            foreach ($childs as $value) {
                $id = $value['id'];
                $j = $k = '';
                if ($number == $total) {
                    $j .= $this->icon[2];
                    $k = $itemprefix ? $this->nbsp : '';
                } else {
                    $j .= $this->icon[1];
                    $k = $itemprefix ? $this->icon[0] : '';
                }
                $spacer = $itemprefix ? $itemprefix . $j : '';
                $selected = $selectedids && in_array($id, (is_array($selectedids) ? $selectedids : explode(',', $selectedids))) ? 'selected' : '';
                $disabled = $disabledids && in_array($id, (is_array($disabledids) ? $disabledids : explode(',', $disabledids))) ? 'disabled' : '';
                $value = array_merge($value, array('selected' => $selected, 'disabled' => $disabled, 'spacer' => $spacer));
                $value = array_combine(array_map(function ($k) {
                    return '@' . $k;
                }, array_keys($value)), $value);
                $nstr = strtr((($value["@{$this->pidname}"] == 0 || $this->getChild($id)) && $toptpl ? $toptpl : $itemtpl), $value);
                $ret .= $nstr;
                $ret .= $this->getTree($id, $itemtpl, $selectedids, $disabledids, $itemprefix . $k . $this->nbsp, $toptpl);
                $number++;
            }
        }
        return $ret;
    }

    /**
     * 树型结构UL
     * @param int    $myid        表示获得这个ID下的所有子级
     * @param string $itemtpl     条目模板 如："<li value=@id @selected @disabled>@name @childlist</li>"
     * @param string $selectedids 选中的ID
     * @param string $disabledids 禁用的ID
     * @param string $wraptag     子列表包裹标签
     * @param string $wrapattr    子列表包裹属性
     * @return string
     */
    public function getTreeUl($myid, $itemtpl, $selectedids = '', $disabledids = '', $wraptag = 'ul', $wrapattr = '')
    {
        $str = '';
        $childs = $this->getChild($myid);
        if ($childs) {
            foreach ($childs as $value) {
                $id = $value['id'];
                unset($value['child']);
                $selected = $selectedids && in_array($id, (is_array($selectedids) ? $selectedids : explode(',', $selectedids))) ? 'selected' : '';
                $disabled = $disabledids && in_array($id, (is_array($disabledids) ? $disabledids : explode(',', $disabledids))) ? 'disabled' : '';
                $value = array_merge($value, array('selected' => $selected, 'disabled' => $disabled));
                $value = array_combine(array_map(function ($k) {
                    return '@' . $k;
                }, array_keys($value)), $value);
                $nstr = strtr($itemtpl, $value);
                $childdata = $this->getTreeUl($id, $itemtpl, $selectedids, $disabledids, $wraptag, $wrapattr);
                $childlist = $childdata ? "<{$wraptag} {$wrapattr}>" . $childdata . "</{$wraptag}>" : "";
                $str .= strtr($nstr, array('@childlist' => $childlist));
            }
        }
        return $str;
    }

    /**
     * 菜单数据
     * @param int    $myid
     * @param string $itemtpl
     * @param mixed  $selectedids
     * @param mixed  $disabledids
     * @param string $wraptag
     * @param string $wrapattr
     * @param int    $deeplevel
     * @return string
     */
    public function getTreeMenu($myid, $itemtpl, $selectedids = '', $disabledids = '', $wraptag = 'ul', $wrapattr = '', $deeplevel = 0)
    {
        $str = '';
        $childs = $this->getChild($myid);
        if ($childs) {
            foreach ($childs as $value) {
                $id = $value['id'];
                unset($value['child']);
                $selected = in_array($id, (is_array($selectedids) ? $selectedids : explode(',', $selectedids))) ? 'selected' : '';
                $disabled = in_array($id, (is_array($disabledids) ? $disabledids : explode(',', $disabledids))) ? 'disabled' : '';
                $value = array_merge($value, array('selected' => $selected, 'disabled' => $disabled));
                $value = array_combine(array_map(function ($k) {
                    return '@' . $k;
                }, array_keys($value)), $value);
                $bakvalue = array_intersect_key($value, array_flip(['@url', '@caret', '@class']));
                $value = array_diff_key($value, $bakvalue);
                $nstr = strtr($itemtpl, $value);
                $value = array_merge($value, $bakvalue);
                $childdata = $this->getTreeMenu($id, $itemtpl, $selectedids, $disabledids, $wraptag, $wrapattr, $deeplevel + 1);
                $childlist = $childdata ? "<{$wraptag} {$wrapattr}>" . $childdata . "</{$wraptag}>" : "";
                $childlist = strtr($childlist, array('@class' => $childdata ? 'last' : ''));
                $value = array(
                    '@childlist' => $childlist,
                    '@url'       => $childdata || !isset($value['@url']) ? "javascript:;" : $value['@url'],
                    '@addtabs'   => $childdata || !isset($value['@url']) ? "" : (stripos($value['@url'], "?") !== false ? "&" : "?") . "ref=addtabs",
                    '@caret'     => ($childdata && (!isset($value['@badge']) || !$value['@badge']) ? '<i class="fa fa-angle-left"></i>' : ''),
                    '@badge'     => isset($value['@badge']) ? $value['@badge'] : '',
                    '@class'     => ($selected ? ' active' : '') . ($disabled ? ' disabled' : '') . ($childdata ? ' treeview' . (config('fastadmin.show_submenu') ? ' treeview-open' : '') : ''),
                );
                $str .= strtr($nstr, $value);
            }
        }
        return $str;
    }

    /**
     * 特殊
     * @param integer $myid        要查询的ID
     * @param string  $itemtpl1    第一种HTML代码方式
     * @param string  $itemtpl2    第二种HTML代码方式
     * @param mixed   $selectedids 默认选中
     * @param mixed   $disabledids 禁用
     * @param string  $itemprefix  前缀
     * @return string
     */
    public function getTreeSpecial($myid, $itemtpl1, $itemtpl2, $selectedids = 0, $disabledids = 0, $itemprefix = '')
    {
        $ret = '';
        $number = 1;
        $childs = $this->getChild($myid);
        if ($childs) {
            $total = count($childs);
            foreach ($childs as $id => $value) {
                $j = $k = '';
                if ($number == $total) {
                    $j .= $this->icon[2];
                    $k = $itemprefix ? $this->nbsp : '';
                } else {
                    $j .= $this->icon[1];
                    $k = $itemprefix ? $this->icon[0] : '';
                }
                $spacer = $itemprefix ? $itemprefix . $j : '';
                $selected = $selectedids && in_array($id, (is_array($selectedids) ? $selectedids : explode(',', $selectedids))) ? 'selected' : '';
                $disabled = $disabledids && in_array($id, (is_array($disabledids) ? $disabledids : explode(',', $disabledids))) ? 'disabled' : '';
                $value = array_merge($value, array('selected' => $selected, 'disabled' => $disabled, 'spacer' => $spacer));
                $value = array_combine(array_map(function ($k) {
                    return '@' . $k;
                }, array_keys($value)), $value);
                $nstr = strtr(!isset($value['@disabled']) || !$value['@disabled'] ? $itemtpl1 : $itemtpl2, $value);

                $ret .= $nstr;
                $ret .= $this->getTreeSpecial($id, $itemtpl1, $itemtpl2, $selectedids, $disabledids, $itemprefix . $k . $this->nbsp);
                $number++;
            }
        }
        return $ret;
    }

}
