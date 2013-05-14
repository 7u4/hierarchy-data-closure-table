DELIMITER $$

USE `_category`$$

DROP PROCEDURE IF EXISTS `p_prefix_nodes_delete_nodes_after_update`$$

CREATE DEFINER = `root` @`localhost` PROCEDURE `p_prefix_nodes_delete_nodes_after_update` (
    `node_id` INT UNSIGNED,
    `deleted` INT UNSIGNED
) COMMENT 'Delete a node and its descendant nodes(update is_deleted = 1)' 
BEGIN
    UPDATE 
        `prefix_nodes` AS d 
        JOIN `prefix_nodes_paths` AS p 
            ON d.`id` = p.`descendant_id` 
        JOIN `prefix_nodes_paths` AS crumbs 
            ON crumbs.`descendant_id` = p.`descendant_id` SET d.`is_deleted` = deleted
    WHERE p.`ancestor_id` = node_id;
END $$

DELIMITER ;

