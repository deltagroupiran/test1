#!/bin/bash

# مقداردهی پیش‌فرض
HEAD=""
BASE=""

# گرفتن پارامترها با فلگ
while [[ "$#" -gt 0 ]]; do
  case $1 in
    --head) HEAD="$2"; shift ;;
    --base) BASE="$2"; shift ;;
    *) echo "❌ Unknown Parameter Passed: $1"; exit 1 ;;
  esac
  shift
done

# بررسی مقداردهی
if [[ -z "$HEAD" || -z "$BASE" ]]; then
  echo "❌ Please Use --head And --base"
  echo "Example:"
  echo " ./gitMerger.sh --head asadi --base develop"
  exit 1
fi

# ساخت عنوان و بدنه
TITLE="Merge ${HEAD} into ${BASE}"
BODY="Merging feature branch ${HEAD} into ${BASE}"

# ایجاد Pull Request
echo "🚀 Create Pull Request From $HEAD To $BASE..."
gh pr create --base "$BASE" --head "$HEAD" --title "$TITLE" --body "$BODY" || {
  echo "❌ Crete PR Failed."; exit 1;
}

# مرج کردن PR
echo "🔀 Creating PR #$"
gh pr merge "$HEAD" --merge || {
  echo "❌ Merge Failed."; exit 1;
}

echo "✅ PR #$PR_NUMBER Success Merged."
