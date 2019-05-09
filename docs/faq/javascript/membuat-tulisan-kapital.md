# Cara membuat tulisan menjadi kapital di JavaScript

!!! TLDR
    ```javascript
    function capitalize (word) {
      return word.charAt(0).toUpperCase() + word.substr(1)
    }
    ```

## Penjelasan

Pada dasarnya tulisan kapital adalah tulisan yang huruf pertama nya besar. Jika input nya adalah
`halo nama saya fariz`, maka outputnya adalah `Halo nama saya fariz`. Pertama, yang kita lakukan
adalah mengambil huruf pertama dari tulisan.

```javascript hl_lines="2"
const tulisan = 'halo nama saya fariz'
const hurufPertama = tulisan.charAt(0)

console.log(hurufPertama) // h
```

Kita bisa mengambil huruf pertama dengan menggunakan method `charAt()`. Method tersebut merupakan properti
dari object `string`, karena variable `tulisan` bertipe `string`. Setelah kita mengambil nilainya
(huruf pertama), sekarang kita buat huruf tersebut "kapital" dengan memanggil methods
`toUpperCase()`, yang sama-sama properti dari object `string`.

```javascript hl_lines="4"
const tulisan = 'halo nama saya fariz'
const hurufPertama = tulisan.charAt(0)

console.log(hurufPertama.toUpperCase()) // H
```

Setelah itu, mari kita gabungkan `hurufPertama` dengan nilai yang ada di variable `tulisan`

```javascript
const tulisan = 'halo nama saya fariz'
const hurufPertama = tulisan.charAt(0)
const hurufDiKapital = hurufPertama.toUpperCase()
const hasil = hurufDiKapital + tulisan

console.log(hasil) // Hhalo nama saya fariz
```

Well, secara teknis sudah benar. Namun bukan itu yang kita inginkan, bukan? Nah, logikanya: _Ambil
semua nilai dari variable `tulisan` kecuali huruf pertama_. Karena nilai huruf pertama sumbernya
dari variable `hurufDiKapital`, kan?

Kita bisa menggunakan method `.substr()` yang masih dari object string tersebut. Method `substr`
menerima 2 parameter: `start` yakni index dari huruf awal yang ingin diambil, dan parameter
`length?`, opsional. Jika nilai `length` diisi, berarti huruf yang akan diambil dari index `start`,
sampai index `length`.

Karena kita cuma ingin _ambil semua huruf kecuali huruf pertama (yakni di index 0)_, berarti kita
isi nilai dari `start` tersebut menjadi `1`.

```javascript hl_lines="4"
const tulisan = 'halo nama saya fariz'
const hurufPertama = tulisan.charAt(0)
const hurufDiKapital = hurufPertama.toUpperCase()
const hasil = hurufDiKapital + tulisan.substr(1)

console.log(hurufDiKapital) // H
console.log(tulisan.substr(1)) // alo nama saya fariz

console.log(hasil) // Halo nama saya fariz

```

## Solved! But, another problem?

Tapi bagaimana bila saya ingin meng-kapitalkan seluruh kata? Misal, menjadi `Halo Nama Saya Fariz`?
Well, menurut gue itu udah beda konteks ya. Bukan "capitalize" lagi, tapi "titlelize". But whatever,
kalau itu yang kalian inginkan, mari kita fikirkan konsepnya.

Ingat kan kalau "String" merupakan kumpulan dari "Char"? "fariz", merupakan kumpulan huruf yang
bernilai:

```
["f", "a", "r", "i", "z"]
  0    1    2    3    4   (index)
```

Maka dari itu kita bisa mengambil nilainya via method `charAt()` dengan parameter index huruf yang
kita ambil. Karena disini kita ingin _mengkapitalkan semua kata_, berarti konsepnya, kita buat
tulisan tersebut menjadi kumpulan string. Misal menjadi begini:

```javascript
["halo", "nama", "saya", "fariz"]
    0       1       2        3     (index)
```

Kita bisa membuatnya menggunakan methods `split()`, dengan parameter "pemisah". Karena dari contoh
diatas, pemisahnya adalah spasi, maka kita isi parameter pemisah tersebut dengan... Spasi.

```javascript hl_lines="2"
const tulisan = 'halo nama saya fariz'
const pisah = tulisan.split(' ')

console.log(pisah) // ['halo', 'nama', 'saya', 'fariz']
```

Nice. Sisanya, tinggal lakukan iterasi untuk setiap kata, dan buat menjadi kapital. Kita bisa saja
menggunakan pengulangan `for`, tapi saya tipe yang menghindari perulangan sebisa mungkin.
Maka disini kita akan menggunakan method `map()`

```javascript
const hasil = pisah.map(huruf =>
  huruf.charAt(0).toUpperCase() + huruf.substr(1)
)

console.log(hasil) // ['Halo', 'Nama', 'Saya', 'Fariz']
```

Cool. Apa maksud dari kode diatas? Pertama, kita buat iterasi terhadap setiap element yang ada,
sisanya, sama seperti fungsionalitas untuk membuat tulisan menjadi kapital tersebut. Bagian ini:

```javascript
pisah.map(huruf =>
  ...
```

Hanyalah "cara singkat" untuk menulis (closure) function yang memiliki 1 parameter dengan identifier `huruf`.
Alias, sama saja seperti ini:

```javascript
const hasil = pisah.map(function (huruf) {
  return ...
}
```

Cara alternatif nya adalah dengan melakukan _looping_ seperti ini:

```javascript
const hasil = []

for (let i = 0; i < pisah.length; i++) {
  hasil.push(pisah[i].charAt(0).toUpperCase() + pisah[i].substr(1))  
}

console.log(hasil) // ['Halo', 'Nama', 'Saya', 'Fariz']
```

Karena fungsi `map`, menghasilkan array baru. Jadi, kita tidak perlu membuat variable lagi untuk
menampung hasil dari operasi "kapitalisasi" kita tersebut. Mungkin bisa saja kita "mutating"
langsung ke array yang dituju, _but seriously?_

## Kesimpulan

Untuk mengkapitalkan semua kata, kode nya adalah seperti ini:

```javascript
function capitalizeAll (words) {
  return words.split(' ')
    .map(word => word.charAt(0).toUpperCase() + word.substr(1))
    .join(' ')
}

```

Atau, demi "DRY", hasil akhirnya adalah seperti ini:

```javascript
function capitalize (word) {
  return word.charAt(0).toUpperCase() + word.substr(1)
}

function capitalizeAll (words) {
  return words.split(' ')
    .map(word => capitalize(word))
    .join(' ')
}
```

`join()` adalah method untuk menggabungkan semua elemen di array menjadi string berdasarkan "pemisah" yang
dimaksud.

## Demo

<iframe src="https://codesandbox.io/embed/oq2wln76k6?fontsize=14&module=%2Fsrc%2Findex.test.js&moduleview=1&previewwindow=tests" title="Cara membuat tulisan menjadi kapital di JavaScript" style="width:100%; height:500px; border:0; border-radius: 4px; overflow:hidden;" sandbox="allow-modals allow-forms allow-popups allow-scripts allow-same-origin"></iframe>

## Apa yang telah kita pelajari disini?

- [`String.prototype.toUpperCase()`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/string/toUpperCase)
- [`String.prototype.charAt(index)`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/string/charAt)
- [`String.prototype.substr(start, length?)`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/string/substr)
- [`String.prototype.split(separator?, limit?)`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/string/split)
- [`Array.prototype.map(callback)`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/array/map)
- [`Array.prototype.join(separator?)`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/array/join)

