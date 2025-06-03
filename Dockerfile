FROM openjdk:11-jdk-slim

# نصب وابستگی‌های لازم
RUN apt-get update && apt-get install -y \
    git \
    curl \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# تنظیم دایرکتوری کاری
WORKDIR /app

# کلون کردن مخزن Grobid
RUN git clone https://github.com/kermitt2/grobid.git . && \
    ./gradlew clean install

# اکسپوز کردن پورت پیش‌فرض Grobid
EXPOSE 8070

# فرمان برای اجرای سرویس Grobid
CMD ["./gradlew", "run"]
