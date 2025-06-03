FROM openjdk:11-jdk-slim

# نصب ابزارهای مورد نیاز
RUN apt-get update && apt-get install -y \
    git \
    curl \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# تنظیم دایرکتوری کاری
WORKDIR /app

# کلون کردن سورس کد و اجرای gradle task مورد نیاز
RUN git clone https://github.com/kermitt2/grobid.git . && \
    ./gradlew clean && \
    ./gradlew grobid-service:onejar

# نمایش فایل تولید شده
RUN ls -lh grobid-service/build/libs/

# اکسپوز کردن پورت
EXPOSE 8070

# اجرای سرویس
CMD ["java", "-Xmx1G", "-jar", "grobid-service/build/libs/grobid-service-onejar.jar", "server", "grobid-service/config/config.yaml"]
