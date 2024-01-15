function get_section_count() = 
    (section_01_inner_depth <= 0) ? 0 : 
    (section_02_inner_depth <= 0) ? 1 :
    (section_03_inner_depth <= 0) ? 2 :
    (section_04_inner_depth <= 0) ? 3 :
    (section_05_inner_depth <= 0) ? 4 :
    (section_06_inner_depth <= 0) ? 5 :
    (section_07_inner_depth <= 0) ? 6 :
    (section_08_inner_depth <= 0) ? 7 :
    (section_09_inner_depth <= 0) ? 8 :
    (section_10_inner_depth <= 0) ? 9 : 10;

function get_section_debth_sum() = [ for (a=0, b=section_debth_concat[0]; a < section_count+1; a= a+1, b=b+(section_debth_concat[a]==undef?0:section_debth_concat[a])) b];

function get_section_debth_concat() = concat(
    section_01_inner_depth, 
    section_02_inner_depth, 
    section_03_inner_depth, 
    section_04_inner_depth, 
    section_05_inner_depth, 
    section_06_inner_depth, 
    section_07_inner_depth, 
    section_08_inner_depth, 
    section_09_inner_depth, 
    section_10_inner_depth
);