# SimpleDialogue NPC Dialogue Generator

Generator HTML offline untuk membuat dialog NPC Roblox dari source `SimpleDialogue.rbxm` yang sudah diekstrak.

## Isi
- `dialogue_generator.html` — editor node/response dan generator Luau.
- `generated/NPC_Dialogue.client.lua` — contoh output self-contained.
- `generated/dialogue.json` — contoh data dialog yang bisa di-load ke generator.

## Cara pakai
1. Buka `dialogue_generator.html` di browser.
2. Buat node NPC dan response pemain.
3. Klik **Generate Luau** lalu **Download Script**.
4. Buat/insert sebuah `Script` di dalam Model NPC di Roblox Studio.
5. Tempel kode hasil generator.
6. Set `RunContext` Script menjadi **Client**.
7. Pastikan NPC punya `Head`, `PrimaryPart`, atau BasePart lain.

## Kenapa RunContext Client?
UI tombol dialog, input `Activated`, dan PlayerGui harus diproses di client. Dengan `RunContext = Client`, satu Script bisa ditempel langsung di NPC tanpa ModuleScript/Fusion tambahan.

## GitHub
Folder ini dibuat GitHub-ready. Upload isi folder ini ke repository, lalu gunakan `dialogue_generator.html` sebagai GitHub Pages bila diperlukan.

Generator tidak melakukan `require()` ke GitHub pada saat game berjalan. Source dibuat self-contained supaya tidak bergantung pada koneksi web saat runtime Roblox.
