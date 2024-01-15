# Sizable Card Box

! Still in progess

This SCAD project is used to produce storage box for your card game. You may add multiple section or use a single one, write custom title to your section and modify the box measurements.


Instruction and description of each personalizable fields:

Global:
- inner_width: Take height mesurement of one of your card.
- inner_height: Take width mesurement of one of your card.

Cover:
- overlap_percent: Percentage of the overlap between you box and cover => [20,10,80]
- latch_type: Would you want latch notch on the width side, depth side or both => [0=Both Side, 1=Width Side Only, 2=Depth Side Only]    
- cover_loose_fit: If your cards are a bit blunt, using this option will remove the full thikness in the cover part. => [true, false]
- cover_label: If you want to write the game name on top of the box
- cover_label_font_family: Trebuchet, Sukhumvit, Silom
- cover_label_font_size: 6 to 18
- cover_label_angle: 0 to 90

For each section (up to 10 sections)
- section_01_inner_depth: Take depth mesurement of all cards to be in that section.
- section_01_label = If you want to write something at the bottom of that section.

- section_XX_inner_depth: Take depth mesurement of all cards to be in that section.
- section_XX_label = If you want to write something at the bottom of that section.