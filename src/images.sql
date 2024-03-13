SELECT 
    `id`,
    `PartName`,
    `Path`
FROM (
    SELECT 
        `parts`.`id` AS `id`,
        `parts`.`name` AS `PartName`,
        REPLACE(`attachments`.`path`, "%MEDIA%", "https://yourServerName/media") AS `Path`,
        ROW_NUMBER() OVER (PARTITION BY `parts`.`id` ORDER BY `attachments`.`id`) AS row_num
    FROM 
        `parts`
    LEFT JOIN 
        `attachments` ON (`attachments`.`element_id` = `parts`.`id`)
    LEFT JOIN 
        `attachment_types` ON (`attachments`.`type_id` = `attachment_types`.`id`)
    WHERE 
        `attachment_types`.`name` = "Image"
) AS subquery
WHERE 
    subquery.row_num = 1;