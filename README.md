<div align="center">
  <h1>42-Inception</h1>
<p align="center">
Bu proje, Docker kullanarak mikroservis mimarisine uygun, izole ve güvenli bir sunucu altyapısı oluşturmayı amaçlar. Her servis, kendi container’ında çalışacak şekilde yapılandırılmıştır. Servisler yalnızca özel bir Docker ağı üzerinden iletişim kurar ve dış dünya ile olan bağlantılar Nginx reverse proxy üzerinden yönetilir. HTTPS desteği için TLS sertifikası OpenSSL ile oluşturulmuş ve yapılandırılmıştır. Böylece veri iletimi şifrelenmiş ve sistem genelinde güvenli bir yapı sağlanmıştır.
</p>
  <img src="https://github.com/deryaxacar/42-inception/blob/main/inception.png" alt="inception" height="150" width="150">
</div>


---

## İçindekiler 📚

- [Proje Açıklaması](#proje-açıklaması)
- [Docker Nedir?](#docker-nedir)
- [Image Nedir?](#image-nedir)
- [Volume Nedir?](#volume-nedir)
- [Nginx Nedir?](#nginx-nedir)
- [Kullanılan Servisler](#kullanılan-servisler)
- [Kurulum ve Kullanım](#kurulum-ve-kullanım)
- [Proje Yapısı](#proje-yapısı)

---

## Proje Açıklaması

Inception, 42 Network’te verilen bir sistem yönetimi projesidir. Amaç, kendi sanal sunucunuzu inşa edip çalıştırmak, bu sunucuda çeşitli servisleri barındırmak ve bu servisleri birbirinden izole bir şekilde Docker container’ları içerisinde çalıştırmaktır. Proje sayesinde:

- Docker ve container mantığı öğrenilir,
- Servislerin birbirleriyle nasıl haberleştirileceği anlaşılır,
- Gerçek dünya sunucu yapılandırmalarına benzer bir yapı kurulur.

---

## 🐳 Docker Nedir?

Docker, uygulamaları ve bu uygulamaların bağımlılıklarını, işletim sisteminden bağımsız bir şekilde çalıştırılabilir hale getiren, açık kaynaklı bir containerization (kapsayıcılama) platformudur. Temel amacı, bir yazılımın geliştirildiği ortamda nasıl çalışıyorsa, aynı şekilde başka bir ortamda da sorunsuz çalışmasını sağlamaktır.

#### 🔧 Docker'ın Temel Bileşenleri

- **Docker Engine**: Docker container’larını oluşturmak, yönetmek ve çalıştırmak için kullanılan çekirdek bileşendir.
- **Docker Image**: Bir uygulamanın çalışması için gerekli tüm kodları, bağımlılıkları ve konfigürasyonları barındıran şablondur.
- **Docker Container**: Image’ların çalıştırılabilir hale gelmiş, izole edilmiş halidir.
- **Dockerfile**: Image’ları otomatik olarak inşa etmek için kullanılan betik dosyasıdır.
- **Docker Compose**: Birden fazla container’ı aynı anda yönetmeye yarayan araçtır (genellikle `docker-compose.yml` dosyası ile yapılandırılır).

---

## Image Nedir?

Docker image (imaj), bir container'ın çalıştırılabilmesi için gerekli olan tüm dosya sistemini, bağımlılıkları ve yapılandırmaları barındıran bir şablondur. Her image, katmanlı bir yapıdadır ve bu image'lardan container'lar oluşturulur.

---

## Volume Nedir?

Docker volume, container’lar ile host sistemi arasında veri paylaşımı sağlamak için kullanılır. Container silinse bile volume’lar kalıcıdır. Bu sayede veri kaybı olmadan işlemler devam eder. Örneğin bir veritabanının verileri volume içerisinde saklanarak container yeniden başlatıldığında kaybolmaz.

---

## Nginx Nedir?

Nginx, açık kaynaklı, yüksek performanslı bir web sunucusudur. Web isteklerini karşılamak, statik dosyaları sunmak ve ters proxy (reverse proxy) olarak çalışmak gibi görevleri vardır. Projede gelen HTTP isteklerini karşılayıp diğer container’lara yönlendirmek için kullanılır.

---

## Kullanılan Servisler

Inception projesinde aşağıdaki servisler kurulup yapılandırılmıştır:

- **Nginx**: Reverse proxy olarak çalışır.
- **WordPress**: İçerik yönetim sistemi.
- **MariaDB**: MySQL uyumlu veritabanı sunucusu.
- **PhpMyAdmin**: MariaDB’yi görsel arayüzle yönetmeye olanak tanır.
- **Redis**: WordPress önbellekleme için kullanılır.
- **FTP (vsftpd)**: Dosya transferi için.

---

## Kurulum ve Kullanım

1. `.env` dosyasını oluşturun ve gerekli ortam değişkenlerini doldurun.
2. Aşağıdaki komutla tüm servisleri başlatın:

```bash
docker-compose up --build
