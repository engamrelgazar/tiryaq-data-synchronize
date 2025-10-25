#!/usr/bin/env bash
set -euo pipefail

echo "▶️ إنشاء فرع جديد..."
git checkout -b chore/rename-all-botble-to-tiryaq || git checkout chore/rename-all-botble-to-tiryaq

echo "▶️ تعديل namespaces والـ use ..."
find src -type f -name '*.php' -print0 | xargs -0 perl -pi -e '
  s/^namespace\s+Botble\\DataSynchronize/namespace Tiryaq\\DataSynchronize/;
  s/\buse\s+Botble\\DataSynchronize\b/use Tiryaq\\DataSynchronize/g;
  s/\buse\s+Botble\\/use Tiryaq\\/g;
  s/([^A-Za-z0-9_\\])Botble\\/${1}Tiryaq\\/g;
'

echo "▶️ تحديث composer.json ..."
TMP=composer.tmp.json
jq '
  .name = "tiryaq/data-synchronize"
  | .type = "tiryaq-package"
  | .autoload = (.autoload // {})
  | .autoload."psr-4" = {"Tiryaq\\DataSynchronize\\":"src/"}
  | .extra = (.extra // {})
  | .extra.laravel = (.extra.laravel // {})
  | .extra.laravel.providers = ["Tiryaq\\DataSynchronize\\Providers\\DataSynchronizeServiceProvider"]
  | .replace = (.replace // {})
  | .replace["botble/data-synchronize"] = "self.version"
' composer.json > "$TMP" && mv "$TMP" composer.json

echo "▶️ عرض الفرق..."
git status
git diff --stat || true

echo "▶️ تنفيذ commit & push..."
git add -A
git commit -m "refactor: convert all use Botble\\* to Tiryaq\\* inside src, update composer.json safely" || true
git push -u origin chore/rename-all-botble-to-tiryaq || true

echo "▶️ إنشاء Pull Request..."
gh pr create --base main --title "refactor: rename all Botble\\* uses to Tiryaq\\* (package-only)" \
  --body "Renamed every 'use Botble\\*' to 'use Tiryaq\\*' inside src, adjusted FQNs, and updated composer.json (name/type/autoload/providers/replace)." || true

echo "🎉 تم التنفيذ بنجاح."
