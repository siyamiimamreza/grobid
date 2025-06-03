FROM openjdk:11-jdk-slim

# نصب ابزارهای مورد نیاز
RUN apt-get update && apt-get install -y \
    git \
    curl \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# تنظیم دایرکتوری کاری
WORKDIR /app

# کلون کردن مخزن Grobid و ساخت پروژه
RUN git clone https://github.com/kermitt2/grobid.git . && \
    ./gradlew clean install

# اکسپوز کردن پورت پیش‌فرض
EXPOSE 8070

# اجرای مستقیم سرویس HTTP
CMD ["java", "-Xmx1G", "-jar", "grobid-service/build/libs/grobid-service-onejar.jar", "server", "grobid-service/config/config.yaml"]
