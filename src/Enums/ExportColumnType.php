<?php

namespace Tiryaq\DataSynchronize\Enums;

use Tiryaq\Base\Supports\Enum;

class ExportColumnType extends Enum
{
    public const DROPDOWN = 'dropdown';

    public const TEXT = 'text';

    public const NUMBER = 'number';

    public const DATETIME = 'datetime';

    public const BOOLEAN = 'boolean';
}
