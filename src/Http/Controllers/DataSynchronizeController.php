<?php

namespace Tiryaq\DataSynchronize\Http\Controllers;

use Tiryaq\Base\Http\Controllers\BaseController;
use Tiryaq\Base\Supports\Breadcrumb;

class DataSynchronizeController extends BaseController
{
    protected function breadcrumb(): Breadcrumb
    {
        return parent::breadcrumb()
            ->add(trans('core/base::layouts.tools'));
    }

    public function index()
    {
        $this->pageTitle(trans('packages/data-synchronize::data-synchronize.tools.export_import_data'));

        return view('packages/data-synchronize::data-synchronize');
    }
}
