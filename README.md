# NixOS

References:

- https://github.com/ghuntley/dotfiles-nixos/
- https://github.com/tycho01/nix-config
- https://github.com/srid/nix-config

## Background

NixOS adalah distro linux, dimana semua paket / software / `package` dan
konfigurasi / `configuration`-nya didesain supaya **immutable**, artinya,
dalam 1 host bisa ada beberapa versi dari setiap paket, walaupun ketika
melakukan `upgrade`. In contrast, distro lain seperti arch, centos, debian
setiap upgrade akan menghapus versi lama setiap paket.

Keuntungan dari imutabilitas ini kita bisa melakukan `rollback` dari setiap
upgrade (`generation`), dengan _tradeoff_ bahwa kita juga harus membuat
konfigurasi setiap paket supaya _mendekati_ immutable juga. Hal ini yang
sebenarnya ditempuh distro lain dengan `ansible` atau `salt`.

```
┌────────┐   ┌────────┐   ┌──────┐
│ centos │ + │ config │ + │ data │
└────────┘   └────────┘   └──────┘
```

Disini developer menginstall centos, lalu login dan membuat konfigurasi, dan
meng-_import_ data jika ada. Disini semua _mutable_, artinya, perubahan dilakukan
dengan merubah install paket secara _ad-hoc_ (`yum install`), file konfigurasi
akan diedit secara _ad-hoc_ juga dengan `nano` / `vim`.

Seiring berjalannya waktu operasi, akan timbul perubahan versi OS, versi paket,
kebutuhan penyesuian config, dll. Hal ini membuat _maintenance_ membutuhkan
banyak waktu dan tenaga.

```
┌─ansible──┐
│┌────────┐│    ┌────────┐   ┌──────┐
││ centos ││ +  │ config │ + │ data │
│└────────┘│    └────────┘   └──────┘
└──────────┘
```

Disini developer menginstall centos, lalu menginstal paket tidak secara _adhoc_
tapi membuat `role` dengan ansible. Hal ini akan mempermudah dan mempersingkat waktu
ketika upgrade OS.

```
┌─ansible──┐   ┌─ansible──┐
│┌────────┐│   │┌────────┐│   ┌──────┐
││ centos ││ + ││ config ││ + │ data │
│└────────┘│   │└────────┘│   └──────┘
└──────────┘   └──────────┘
```

Model ini maju selangkah lagi, konfigurasi disimpan dalam bentuk `template`,
biasanya `jinja`. Upgrade OS dan penyesuaian konfig lebih mudah di kemudian hari.
Jika dilihat dari 3 pola diatas, yang dilakukan sebenarnya adalah meminimalisasi
proses perubahan / _mutation_, karena ansible secara prinsip akan menjaga hasil akhir
produk supaya semirip mungkin dengan perubahan sebelummnya, walaupun OS / config
di dalamnya berubah


```
              ┌─nix───────────────────┐
┌────────┐    │┌──────────┐ ┌────────┐│   ┌──────┐
│ centos │  + ││ packages │+│ config ││ + │ data │
└────────┘    │└──────────┘ └────────┘│   └──────┘
              └───────────────────────┘
```

Disini fungsi `rpm` yang dibungkus `ansible` diganti `nix`, sehingga instalasi
paket dan config bisa _immutable_. Centos cukup diupgrade jika sudah ada versi baru,
tapi paket dan config selalu bisa diupdate dan di rollback


```
┌───────┐   ┌──────┐
│ nixos │ + │ data │
└───────┘   └──────┘
```

Disini ganti total pake NixOS. semua immutable, tentu terkecuali data. Jadi bisa
dikatakan, dalam bahasa yang sederhana, `nixos` adalah integrasi OS + ansible.

## Rationale

Untuk penerapan continuous integration / continuous deployment di JogjaCamp,
dibutuhkan `bootstrapping` berupa aplikasi / `tooling` untuk mendukungnya, seperti
`ansible`, `testinfra`, `buildbot` dan `gitea`, dimana untuk membuatnya jika
harus menggunakan CI/CD juga, maka akan dibutuhkan `ansible` di bawahnya lagi.
Ini seperti telur dan ayam, mana yang duluan

NixOS akan digunakan untuk membuat `bootstrap` / dasar untuk CI/CD tersebut, karena
sejak awal sudah _immutable_. Sehingga `whole stack` akan mendekati imutabilitas,
sehingga tahan terhadap virus, apakagi di era Covid-19 saat ini.

## Skema

TBD

## Instalasi

Create VM, booting pake nixos live CD di sriwijaya. Buat password via console lalu SSH

```
# passwd nixos
# systemctl start sshd
```

Lalu SSH dan sudo, siapkan partisi

```
# parted /dev/xvda -- mklabel msdos
# parted /dev/xvda -- mkpart primary 1MiB -2GiB
# parted /dev/xvda -- mkpart primary linux-swap -2GiB 100%
```

Lalu instal nixos

```
# mkfs.ext4 -L nixos /dev/xvda1
# mkswap -L swap /dev/xvda2
# swapon /dev/xvda2
# mount /dev/disk/by-label/nixos /mnt
# nixos-generate-config --root /mnt
# nano /mnt/etc/nixos/configuration.nix
# nixos-install
# reboot
```