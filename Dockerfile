FROM node:14-alpine

# 同步容器时间
RUN sed -i 's/https/http/' /etc/apk/repositories
RUN apk --update add tzdata && \
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone && \
    apk del tzdata && \
    rm -rf /var/cache/apk/*


# 创建 app 目录
WORKDIR /usr/src/app

# 安装 app 依赖
# RUN npm -g install serve

# 使用通配符复制 package.json 与 package-lock.json
COPY package*.json ./

RUN npm config set strict-ssl false
RUN npm install

# 打包 app 源码
COPY src .

# 如需对 react/vue/angular 打包，生成静态文件，使用：
# RUN npm run build

# 暴露端口
# EXPOSE 3000

# 如需部署静态文件，使用：
# CMD [ "node", "index.js", "mode=dev"]
CMD [ "node", "index.js"]