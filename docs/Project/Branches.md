# ブランチの扱い方

## 各ブランチの概要

基本的には一般的なgit flowモデルに近い形。  

|ブランチ名|概要|派生元ブランチ|push可能？|
|---|---|---|---|
|master|マスタブランチ||×|
|production|一般的なgit flowで言う所の「develop」ブランチ|master|×|
|develop_XXX|それぞれの環境毎に用意されたdevelopブランチ|production|×|
|feature/XXX|機能実装用ブランチ|develop_XXX|○|
|bugfix/XXX|不具合修正用ブランチ|develop_XXX|○|
|hotfix/XXX|緊急対応用ブランチ|master|○|
|feature_XXX|作業用ブランチ|develop_XXX|○|
