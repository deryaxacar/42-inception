<div align="center">
  <h1>42-Inception</h1>
<p align="center">
Bu proje, Docker kullanarak mikroservis mimarisine uygun, izole ve güvenli bir sunucu altyapısı oluşturmayı amaçlar. Her servis, kendi container’ında çalışacak şekilde yapılandırılmıştır. Servisler yalnızca özel bir Docker ağı üzerinden iletişim kurar ve dış dünya ile olan bağlantılar Nginx reverse proxy üzerinden yönetilir. HTTPS desteği için TLS sertifikası OpenSSL ile oluşturulmuş ve yapılandırılmıştır. Böylece veri iletimi şifrelenmiş ve sistem genelinde güvenli bir yapı sağlanmıştır.
</p>
  <img src="https://github.com/deryaxacar/42-inception/blob/main/inception.png" alt="inception" height="150" width="150">
</div>


---

## İçindekiler 📚

- [Sanal Mimari Nedir?](#sanal-mimari-nedir)
- [Konteyner Mimari Nedir?](#konteyner-mimari-nedir)
- [Kernel Nedir?](#kernel-nedir)
- [Docker Nedir?](#docker-nedir)
- [Image Nedir?](#image-nedir)
- [Volume Nedir?](#volume-nedir)
- [Nginx Nedir?](#nginx-nedir)
- [Kullanılan Servisler](#kullanılan-servisler)

---

## <a name="sanal-mimari-nedir"></a>🖥️ Sanal Mimari (Virtual Machine Architecture) Nedir?

- Fiziksel donanım üzerinde çalışan bir hypervisor yardımıyla, birden fazla sanal makine (VM) oluşturulur.
- Her sanal makine kendi işletim sistemi ile birlikte çalışır.
- Donanım seviyesinde izolasyon sağlar.

**Özellikleri:**

- Ağırdır, daha fazla kaynak kullanır.
- Daha güvenlidir.
- Her VM'de ayrı işletim sistemi çalışabilir.

Hypervisor, fiziksel donanım ile sanal makineler arasında bir köprü görevi görür. Sanal makinelerin (VM) her biri, kendi işletim sistemine ve uygulamalarına sahipmiş gibi çalışır. Ancak aslında bu sistemler, hypervisor tarafından paylaştırılan kaynaklarla (CPU, RAM, disk vb.) çalışır.

---

![img](https://github.com/deryaxacar/42-inception/blob/main/img/sanal-mimari.png)

---

Not: Sanal makina üzerinde çalışan işletim sistemi arkaplanda çalışan hipervisordan haberdar değildir.
Sanal makina fiziksel bir makina gibi davranır.

---

## <a name="konteyner-mimari-nedir"></a>📦 Konteyner Mimari (Container Architecture) Nedir?

- Uygulamalar, aynı işletim sistemini paylaşan, ancak birbirinden izole çalışan konteynerler içinde çalışır.
- İzolasyon, işletim sistemi çekirdeği (kernel) düzeyinde sağlanır (namespaces, cgroups).
- Konteynerler hızlı başlar, hafiftir.

**Özellikleri:**

- Kaynak kullanımı azdır.
- Başlatma süresi çok kısadır.
- Uygulama geliştirme ve dağıtımı için idealdir.

---

![img](https://github.com/deryaxacar/42-inception/blob/main/img/konteyner-mimari.png)

---

Konteynerlar Teknolojilerinde ise işletim sistemi kernelına eklenen featureler (özellikler) kullanılarak işlem izolasyonu sağlanmaktadır.
Bu işlem izolasyonu sayesinde aynı işletim sistemi üzerinde birbirinden bağımsız konteynerler oluşturulabilmektedir.

---

## Kernel Nedir?

Kernel, şletim sisteminin "çekirdeğidir". Bilgisayarın donanımı ile yazılımı arasında köprü görevi görür. Yani:

- Bellek yönetimi
- Dosya sistemi
- Ağ erişimi
- İşlem yönetimi
- Donanımla doğrudan iletişim

gibi temel işleri kernel yapar.

![img](https://github.com/deryaxacar/42-inception/blob/main/img/kernel.png)

**örnek:**

- Sen bir programda print("Merhaba") yazarsın,
- Bu işlem işletim sistemine gider,
- İşletim sistemi bu talebi kernel aracılığıyla ekrana iletir.

---

## <a name="docker-nedir"></a>🐳 Docker Nedir?

Docker, uygulamaları ve bu uygulamaların bağımlılıklarını, işletim sisteminden bağımsız bir şekilde çalıştırılabilir hale getiren, açık kaynaklı bir containerization (kapsayıcılama) platformudur. Temel amacı, bir yazılımın geliştirildiği ortamda nasıl çalışıyorsa, aynı şekilde başka bir ortamda da sorunsuz çalışmasını sağlamaktır.

---

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

## Kullanılan Servisler

Inception projesinde aşağıdaki servisler kurulup yapılandırılmıştır:

- **Nginx**: Reverse proxy olarak çalışır.
- **WordPress**: İçerik yönetim sistemi.
- **MariaDB**: MySQL uyumlu veritabanı sunucusu.

---

![img](https://github.com/deryaxacar/42-inception/blob/main/img/inceptionimg.PNG)

---

