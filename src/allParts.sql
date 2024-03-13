select `parts`.`id` AS `id`,
        CONCAT('https://yourServerName/en/part/', `parts`.`id`) AS `PartDb`,
        `parts`.`name` AS `name`,
        replace(`parts`.`ipn`,concat('_',substring_index(`parts`.`ipn`, '_',-1)),'') AS `PartNumber`,
        `parts`.`description` AS `description`,
        `categories`.`name` AS `category`,
        `footprints`.`name` AS `footprint`,
        `manufacturers`.`name` AS `manufacturer`,
        `parts`.`favorite` AS `favorite`,
        `parts`.`manufacturer_product_number` AS `mpn`,
        `parts`.`manufacturing_status` AS `manufacturing_status`,
        `parts`.`needs_review` AS `needs_review`,
        `parts`.`tags` AS `tags`,
        `parts`.`eda_info_reference_prefix` AS `EDA_reference_prefix`,
        `parts`.`eda_info_value` AS `EDA_value`,
        `parts`.`eda_info_exclude_from_bom` AS `EDA_exclude_from_bom`,
        `parts`.`eda_info_exclude_from_board` AS `EDA_exclude_from_board`,
        `parts`.`eda_info_exclude_from_sim` AS `EDA_exclude_from_sim`,
        `parts`.`eda_info_kicad_symbol` AS `EDA_symbol`,
        REPLACE(SUBSTRING_INDEX(`parts`.`eda_info_kicad_footprint`, ',', 1), ' ', '') AS EDA_footprint1,
        REPLACE(IF(SUBSTRING_INDEX(SUBSTRING_INDEX(`parts`.`eda_info_kicad_footprint`, ',', 2), ',', -1)=`parts`.`eda_info_kicad_footprint`, NULL, SUBSTRING_INDEX(SUBSTRING_INDEX(`parts`.`eda_info_kicad_footprint`, ',', 2), ',', -1)), ' ', '')  AS EDA_footprint2,
        REPLACE(IF(SUBSTRING_INDEX(`parts`.`eda_info_kicad_footprint`, ',', -1)=`parts`.`eda_info_kicad_footprint`, NULL, SUBSTRING_INDEX(`parts`.`eda_info_kicad_footprint`, ',', -1)), ' ', '') AS EDA_footprint3,
        `datasheets`.`PartName` AS `datasheetName`,
        `datasheets`.`Path` AS `datasheetPath`,
        `images`.`PartName` AS `imageName`,
        `images`.`Path` AS `imagePath`,
        `parts`.`datetime_added` AS `datetime_added`,
        `parts`.`last_modified` AS `last_modified`
from (((((`parts`
    left join `categories` on (`parts`.`id_category` = `categories`.`id`))
    left join `footprints` on (`parts`.`id_footprint` = `footprints`.`id`))
    left join `manufacturers` on (`parts`.`id_manufacturer` = `manufacturers`.`id`))
    left join `datasheets` on (`datasheets`.`id` = `parts`.`id`))
    left join `images` on (`images`.`id` = `parts`.`id`))
where (`parts`.`eda_info_invisible` = 1)


