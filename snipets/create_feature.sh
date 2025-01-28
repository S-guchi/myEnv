#!/bin/bash

# フォルダ構造を作成する関数
create_structure() {
    local feature_name=$1
    
    if [ -z "$feature_name" ]; then
        echo "Usage: $0 <feature_name>"
        exit 1
    fi
    
    # ベースディレクトリ
    base_dir="lib/features/$feature_name"
    
    # ディレクトリとファイルの構造
    directories=(
        "$base_dir/view"
        "$base_dir/view_model"
        "$base_dir/model"
        "$base_dir/providers"
    )
    
    files=(
        "$base_dir/view/${feature_name}_screen.dart"
        "$base_dir/view_model/${feature_name}_view_model.dart"
        "$base_dir/view_model/${feature_name}_state.dart"
        "$base_dir/model/${feature_name}_model.dart"
        "$base_dir/providers/${feature_name}_provider.dart"
    )
    
    # ディレクトリを作成
    for dir in "${directories[@]}"; do
        if [ ! -d "$dir" ]; then
            mkdir -p "$dir"
            echo "Created directory: $dir"
        fi
    done
    
    # ファイルを作成
    for file in "${files[@]}"; do
        if [ ! -f "$file" ]; then
            echo "// $(basename "$file")" > "$file"
            echo "Created file: $file"
        fi
    done
}

# メイン処理
create_structure "$1"
