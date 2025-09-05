# 常用 Terminal 指令速查表

## 🔹 檔案與目錄操作

-   `pwd` → 顯示當前所在路徑 (Print Working Directory)\
-   `ls` → 列出檔案與資料夾
    -   `ls -l` → 詳細資訊\
    -   `ls -a` → 顯示隱藏檔 (以 `.` 開頭)\
-   `cd <目錄>` → 切換資料夾 (Change Directory)\
-   `mkdir <目錄>` → 建立新資料夾 (Make Directory)\
-   `rmdir <目錄>` → 刪除空資料夾\
-   `rm -rf <目錄>` → 強制刪除資料夾（危險，要小心！）\
-   `touch <檔案>` → 建立新檔案\
-   `cp <來源> <目的>` → 複製檔案或資料夾
    -   `cp -r <資料夾>` → 遞迴複製整個資料夾\
-   `mv <來源> <目的>` → 移動/重新命名檔案

## 🔹 檔案內容檢視

-   `cat <檔案>` → 顯示檔案內容\
-   `less <檔案>` → 分頁查看檔案內容（可上下翻頁）\
-   `head -n 10 <檔案>` → 顯示檔案前 10 行\
-   `tail -n 10 <檔案>` → 顯示檔案最後 10 行\
-   `tail -f <檔案>` → 實時追蹤檔案更新（常用於 log 檔）

## 🔹 搜尋與過濾

-   `find <路徑> -name <檔名>` → 在目錄下找檔案\
-   `grep <關鍵字> <檔案>` → 在檔案中搜尋文字
    -   `grep -r <關鍵字> <資料夾>` → 遞迴搜尋整個資料夾\
-   `wc -l <檔案>` → 計算檔案行數

## 🔹 系統與環境

-   `whoami` → 顯示目前使用者\
-   `uname -a` → 顯示系統資訊\
-   `top` → 顯示即時系統資源使用狀況\
-   `ps aux` → 列出目前所有行程 (process)\
-   `kill <PID>` → 終止指定的行程\
-   `env` → 顯示所有環境變數\
-   `echo $PATH` → 顯示 PATH 設定

## 🔹 權限相關

-   `chmod 755 <檔案>` → 修改檔案權限\
-   `chown 使用者:群組 <檔案>` → 修改檔案擁有者\
-   `sudo <指令>` → 以管理員權限執行

## 🔹 網路操作

-   `ping <網址或IP>` → 測試連線\
-   `curl <網址>` → 抓取網頁內容\
-   `wget <網址>` → 下載檔案（部分系統需額外安裝）\
-   `ifconfig` 或 `ip a` → 查看網路介面資訊

## 🔹 檔案壓縮 / 解壓縮

-   `tar -czvf archive.tar.gz <檔案/資料夾>` → 打包並壓縮\
-   `tar -xzvf archive.tar.gz` → 解壓縮\
-   `zip -r archive.zip <檔案/資料夾>` → 壓縮成 ZIP\
-   `unzip archive.zip` → 解壓縮 ZIP

## 🔹 其他常用技巧

-   `clear` → 清空終端機畫面\
-   `history` → 查看歷史指令\
-   `!!` → 執行上一個指令\
-   `Ctrl + C` → 中斷當前指令\
-   `Ctrl + Z` → 暫停程序\
-   `fg` → 恢復到前景執行\
-   `&` → 指令後加上 `&` 代表背景執行

# 🍎 macOS 常用快捷鍵

## 🔹 系統操作

-   `Command (⌘) + Space` → 打開 Spotlight 搜尋\
-   `Command (⌘) + Tab` → 切換應用程式\
-   `Command (⌘) + Q` → 關閉應用程式\
-   `Command (⌘) + W` → 關閉視窗 / 分頁\
-   `Command (⌘) + Option + Esc` → 強制結束應用程式\
-   `Command (⌘) + Shift + 3` → 全螢幕截圖\
-   `Command (⌘) + Shift + 4` → 選取範圍截圖\
-   `Command (⌘) + Shift + 5` → 開啟截圖工具（錄影也能用）

## 🔹 文字編輯

-   `Command (⌘) + C` → 複製\
-   `Command (⌘) + X` → 剪下\
-   `Command (⌘) + V` → 貼上\
-   `Command (⌘) + Z` → 復原\
-   `Command (⌘) + Shift + Z` → 重做\
-   `Command (⌘) + A` → 全選\
-   `Command (⌘) + 左箭頭` → 移到行首\
-   `Command (⌘) + 右箭頭` → 移到行尾\
-   `Option + 左/右箭頭` → 游標以單字為單位移動\
-   `Option + Delete` → 刪掉整個單字\
-   `Command (⌘) + Delete` → 刪掉整行

## 🔹 Finder

-   `Command (⌘) + N` → 新 Finder 視窗\
-   `Command (⌘) + Shift + N` → 建立新資料夾\
-   `Command (⌘) + Delete` → 移到垃圾桶\
-   `Command (⌘) + Shift + Delete` → 清空垃圾桶

## 🔹 Terminal

-   `Ctrl + A` → 游標移到行首\
-   `Ctrl + E` → 游標移到行尾\
-   `Ctrl + U` → 刪掉游標前方整行\
-   `Ctrl + K` → 刪掉游標後方文字\
-   `Ctrl + W` → 刪掉游標前一個字詞\
-   `Ctrl + L` → 清除螢幕（等同 `clear`）\
-   `Ctrl + C` → 中斷正在執行的程式\
-   `Ctrl + D` → 登出或結束 Shell

## 🔹 瀏覽器

-   `Command (⌘) + T` → 新分頁\
-   `Command (⌘) + W` → 關閉分頁\
-   `Command (⌘) + Shift + T` → 重新開啟上一個關閉的分頁\
-   `Command (⌘) + L` → 快速定位網址列\
-   `Command (⌘) + R` → 重新整理網頁\
-   `Command (⌘) + Option + I` → 開啟開發者工具
