# The Freshman Learning Note

## The introduction to Git&Github, Docker
3部影片資源：[零基礎上手] [1], 
[10分鐘學會工作流] [2], [40分鐘Docker實戰] [3].

  [1]: htt40分鐘Docker實戰//www.youtube.com/watch?v=FKXRiAiQFiY        "零基礎上手"
  [2]: htt40分鐘Docker實戰//www.youtube.com/watch?v=uj8hjLyEBmU  "10分鐘學會工作流"
  [3]: htt40分鐘Docker實戰//www.youtube.com/watch?v=_-IPi1a774E    "40分鐘Docker實戰arch"

----------------
### [10分鐘學會工作流]影片內容總結

這支影片透過簡明步驟，教你如何建立一個標準化、與開源專案一致的 GitHub
工作流程。以下是具體流程整理：

1.  **Clone 倉庫**

    ``` bash
    git clone <repo_url>
    ```

2.  **建立分支**

    ``` bash
    git checkout -b <your-branch-name>
    ```

3.  **開發與修改**\
    在新分支上進行功能開發、代碼修改。

4.  **檢查差異 (diff)**

    ``` bash
    git diff
    ```

5.  **新增到暫存區 (add)**

    ``` bash
    git add <file>
    ```

    或使用 `git add .` 將所有修改加入暫存區。

6.  **提交 (commit)**

    ``` bash
    git commit -m "Your commit message"
    ```

7.  **推送到遠端分支**

    ``` bash
    git push origin <your-branch-name>
    ```

8.  **同步主分支更新**

    ``` bash
    git checkout main
    git pull origin main
    git checkout <your-branch-name>
    git rebase main
    ```

9.  **再次推送更新後的分支**

    ``` bash
    git push origin <your-branch-name>
    ```

10. **提出 Pull Request**\
    前往 GitHub 專案頁面，發起 **Pull Request**，請求合併變更。

------------------------------------------------------------------------

### [40分鐘Docker實戰]影片內容總結

1. **Docker 核心概念**

-   容器（Container）與映像檔（Image）的差別。
-   Docker 與傳統虛擬機（VM）的差異。

2. **跨平台安裝 Docker**

-   Linux:

    ``` bash
    sudo apt-get update
    sudo apt-get install docker.io
    ```

-   檢查版本：

    ``` bash
    docker --version
    ```

3. **下載鏡像與配置鏡像站**

-   下載鏡像：

    ``` bash
    docker pull ubuntu
    docker pull nginx
    ```

-   查看本地鏡像：

    ``` bash
    docker images
    ```

4. **使用 `docker run` 啟動容器**

-   啟動交互式容器：

    ``` bash
    docker run -it ubuntu /bin/bash
    ```

-   背景執行：

    ``` bash
    docker run -d nginx
    ```

-   指定端口映射：

    ``` bash
    docker run -d -p 8080:80 nginx
    ```

-   查看正在運行的容器：

    ``` bash
    docker ps
    ```

5. **進入容器進行調試**

-   使用 `exec`：

    ``` bash
    docker exec -it <container_id> /bin/bash
    ```

-   使用 `attach`：

    ``` bash
    docker attach <container_id>
    ```

-   查看日誌：

    ``` bash
    docker logs <container_id>
    ```

6. **Docker 網路模式**

-   查看網路：

    ``` bash
    docker network ls
    ```

-   建立 bridge 網路：

    ``` bash
    docker network create --driver bridge my_network
    ```

-   使用自訂網路啟動容器：

    ``` bash
    docker run -d --network=my_network --name my_nginx nginx
    ```

-   host 模式：

    ``` bash
    docker run -d --network host nginx
    ```

-   none 模式：

    ``` bash
    docker run -d --network none nginx
    ```

7. **Docker Compose 基礎**

-   `docker-compose.yml` 範例：

    ``` yaml
    version: "3"
    services:
      web:
        image: nginx
        ports:
          - "8080:80"
      db:
        image: mysql:5.7
        environment:
          MYSQL_ROOT_PASSWORD: root
    ```

-   啟動：

    ``` bash
    docker-compose up -d
    ```

-   停止：

    ``` bash
    docker-compose down
    ```

8. **AI 輔助學習 Docker**

-   建議搭配 AI 工具詢問指令用途、錯誤排查方式，加速理解與學習。
  

(在VScode裡面下載“markdown all in one”之後，便可以有markdown的粗體快捷鍵cmd+b)

------------------------------------------------------------------------


## Introduction to yaml

- Example 1 (```docker-compose.yml```): 
    ``` yaml
    services:
    app:
        image: ${IMAGE}
        container_name: my-container
        stdin_open: true
        tty: true
        environment:
        MYSQL_HOST: ${LINE_GO_DB_HOST_DEV}
        MYSQL_USER: ${LINE_GO_DB_USER_DEV}
        MYSQL_PASSWORD: ${LINE_GO_DB_PASSWORD_DEV_ENCODE}
        MYSQL_DATABASE: ${LINE_GO_DB_DATABASE_DEV}
        DAILY_LOTTERY_LIST_SUFFIX: _dev
    ```

- Example 2 (```docker-compose.override.yml```): 
    ``` yaml
    services:
    app:
        environment:
        UPLOAD_SIZE: 10000
        volumes:
        - .:/app
        - /app/.venv
        - /app/data
    ```

## Review for ```class``` and ```function```


## 上版教學
----------
## TODO_20250904
- 熟悉terminal指令，今天TODO是在terminal裡面修改TODO.md，以及昨天的會議記錄
  - 目前操作過的terminal指令：pwd, ls -l, touch, mkdir, cd .., echo, cat, less, open
  - 之後寫TODO會使用這個方式
- 早上10點會議前用terminal操作看看昨天專案管理課中的uv、文件結構
- 早上10點參加認識資料的會議
- 會後大概午餐前會在處理新人SQL題
- 下午完成SQL, 若能提早完成便複習下這幾天的學習內容，有多餘時間看下lightGBM
- -----
## uv, makefile
- 建立新專案
```make new-project project = {}```
- 開虛擬機
```uv venv```
----------
raw data: carplus_latest較舊，較新為adw_base (sincere)
yulon: 存發票(發票怪獸)
prod_sensors_data: CDP，網站和APP瀏覽行為events，另有後端資料（訂單）

----------
Question: 當月新用戶如何定義(是當月註冊並用車的人、還是第一次下單的人)
Check: 用戶應該是所有註冊成功的人
Check: 註冊時長是註冊完成(upd_dt)到完單日期 
Question: 審核時長是built到finished還是註冊完成到finished

一個月內應該是指 完單在一個月內的資料
新用戶=首次交易用戶？

以1個月內的版本來說：
STEP 1: 先把整體資料分成第一次完單的新戶訂單和不是第一次完單的舊戶訂單
STEP 2: 取出1個月內(當月)的完單資料，像今天9月4日就選9月1日到9月3日
STEP 3: 算出新舊用戶比例
STEP 4: 專門看新戶的註冊完成到完單的時長和審核完成到完單的時長 (按月平均)

然後STEP 2的地方，如果是1-3個月的版本就取6,7,8月，以此類推

----------

### 認識資料

prod tableau
adw_base

----------

## TODO 20250905

- **早上調整SQL題**：目前的問題是第1題的「不同年齡」在考慮用訂單建立當下的年齡、還是用顧客當前的年齡。然後和Cathy討論第2題的做法。會再檢查一下正確性。
- 背景播放新訓影片
- 預先看下week 2的教學影片，構想簡報架構與內容
- **複習**：自己嘗試用makefile建立檔案、env建立虛擬環境到.env, path, yaml的流程走一遍

### 終版確認

- SQL題
- week安排按照進度進行
- 理解一遍python專案管理，力求迅速理解背後架構
- **再多一題SQL題**
  計算 2020年起 有做過日租或共享一次交易（不限平台，時間範圍統計到 2025/08/31前），且在 2025/08/31前有登入GOSMART APP的用戶數
  `centering-oxide-345205.prod_carplus_adw.s2g_orders_completed`
  `centering-oxide-345205.prod_carplus_adw.srental_orders_completed`
  `sincere-strata-288408.adw_base.auth_carplus_users`
- 先看稼動率模型
      `sincere-strata-288408.feature_store.caravail_by_day` a
      `centering-oxide-345205.prod_carplus_adw.s2g_orders_completed` b
      `centering-oxide-345205.prod_carplus_adw.customers` c
    `sincere-strata-288408.feature_store.caravail_by_day` a

---------

## TODO 20250908

- 和Cathy討論WEEK 1學習歷程的兩道SQL題，討論沒問題後發起會議，把Heisenberg和Shannis加進來
- 可以先看WEEK 2的任務內容，因為還要組織會議，計劃禮拜三前準備好簡報，並把與會同仁(應該是所有分析師)拉進會議。有空檔要發想下query後結果可以帶來的商業洞見
- 學習平台上新人訓練的影片都已經完成
- 列出一些關於之後ML會用到的表格的疑問
- 回顧下目前學習過的重點：Git工作流、Docker概念、yaml檔和.env檔、uv和makefile、markdown文件撰寫、terminal操作、Python函數與class、認識資料
- 目前比較不熟的是makefile的內容是怎樣的架構、yaml檔和.env檔什麼時機點會要用到及其區別
- 隨時接收有關Python的學習規劃