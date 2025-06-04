FROM openjdk:11-jdk-slim

# نصب ابزارهای مورد نیاز
RUN apt-get update && apt-get install -y \
    git \
    curl \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# تنظیم دایرکتوری کاری
WORKDIR /app

# کلون کردن سورس کد و بیلد پروژه
RUN git clone https://github.com/kermitt2/grobid.git . && \
    ./gradlew clean && \
    ./gradlew grobid-service:jar

# بررسی فایل jar ساخته‌شده
RUN ls -lh grobid-service/build/libs/

# اکسپوز کردن پورت سرویس
EXPOSE 8070

# اجرای سرویس با jar ساخته‌شده
CMD ["java", "-Xmx1G", "-jar", "grobid-service/build/libs/grobid-service.jar", "server", "grobid-service/config/config.yaml"]
