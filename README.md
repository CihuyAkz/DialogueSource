# SimpleDialogue NPC Generator v3

Generator HTML offline untuk membuat **1 Script Roblox** yang ditempel langsung di dalam Model NPC.

## Penempatan script hasil generate

```text
Workspace
└── NPC Model
    ├── Head
    ├── Humanoid
    └── DialogueScript   <-- paste hasil generate di sini
```

Buat **Script** biasa, lalu set:

- `RunContext = Client`
- `Enabled = true`

Generator sekarang menambahkan guard `RunService:IsClient()` sehingga kesalahan konfigurasi RunContext terlihat jelas di Output.

## Perbaikan v3

- Menghapus bug yang menambahkan `$https://github.com/CihuyAkz/DialogueSource` ke akhir Luau.
- URL repository hanya disimpan sebagai komentar metadata.
- Menambahkan validasi `RunContext = Client`.
- Menghindari global `displayNode` dengan local forward declaration.
- Menambahkan anotasi untuk reference UI optional agar lebih aman di mode `--!strict`.
- Output download menggunakan ekstensi `.lua`.
- Tetap memakai snapshot `SimpleDialogue.rbxm` yang sebelumnya diunggah sebagai baseline embedded/offline.
