USE storageo_knowledge;


# contenttypes 0001_initial
BEGIN;
CREATE TABLE `django_content_type` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `name` varchar(100) NOT NULL, `app_label` varchar(100) NOT NULL, `model` varchar(100) NOT NULL);
ALTER TABLE `django_content_type` ADD CONSTRAINT `django_content_type_app_label_3ec8c61c_uniq` UNIQUE (`app_label`, `model`);
COMMIT;


# contenttypes 0002_remove_content_type_name
BEGIN;
ALTER TABLE `django_content_type` MODIFY `name` varchar(100) NULL;
--
-- MIGRATION NOW PERFORMS OPERATION THAT CANNOT BE WRITTEN AS SQL:
-- Raw Python operation
--
ALTER TABLE `django_content_type` DROP COLUMN `name` CASCADE;
COMMIT;


# auth 0001_initial
BEGIN;
CREATE TABLE `auth_permission` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `name` varchar(50) NOT NULL, `content_type_id` integer NOT NULL, `codename` varchar(100) NOT NULL, UNIQUE (`content_type_id`, `codename`));
CREATE TABLE `auth_group` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `name` varchar(80) NOT NULL UNIQUE);
CREATE TABLE `auth_group_permissions` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `group_id` integer NOT NULL, `permission_id` integer NOT NULL, UNIQUE (`group_id`, `permission_id`));
CREATE TABLE `auth_user` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `password` varchar(128) NOT NULL, `last_login` datetime(6) NOT NULL, `is_superuser` bool NOT NULL, `username` varchar(30) NOT NULL UNIQUE, `first_name` varchar(30) NOT NULL, `last_name`
 varchar(30) NOT NULL, `email` varchar(75) NOT NULL, `is_staff` bool NOT NULL, `is_active` bool NOT NULL, `date_joined` datetime(6) NOT NULL);
CREATE TABLE `auth_user_groups` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `user_id` integer NOT NULL, `group_id` integer NOT NULL, UNIQUE (`user_id`, `group_id`));
CREATE TABLE `auth_user_user_permissions` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `user_id` integer NOT NULL, `permission_id` integer NOT NULL, UNIQUE (`user_id`, `permission_id`));
ALTER TABLE `auth_permission` ADD CONSTRAINT `auth_permissi_content_type_id_51277a81_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);
ALTER TABLE `auth_group_permissions` ADD CONSTRAINT `auth_group_permissions_group_id_58c48ba9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);
ALTER TABLE `auth_group_permissions` ADD CONSTRAINT `auth_group_permissi_permission_id_23962d04_fk_auth_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`);
ALTER TABLE `auth_user_groups` ADD CONSTRAINT `auth_user_groups_user_id_24702650_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);
ALTER TABLE `auth_user_groups` ADD CONSTRAINT `auth_user_groups_group_id_30a071c9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);
ALTER TABLE `auth_user_user_permissions` ADD CONSTRAINT `auth_user_user_permissions_user_id_7cd7acb6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);
ALTER TABLE `auth_user_user_permissions` ADD CONSTRAINT `auth_user_user_perm_permission_id_3d7071f0_fk_auth_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`);
COMMIT;


# auth 0002_alter_permission_name_max_length
BEGIN;
ALTER TABLE `auth_permission` MODIFY `name` varchar(255) NOT NULL;
COMMIT;


# auth 0003_alter_user_email_max_length
BEGIN;
ALTER TABLE `auth_user` MODIFY `email` varchar(254) NOT NULL;
COMMIT;


# auth 0004_alter_user_username_opts


# auth 0005_alter_user_last_login_null
BEGIN;
ALTER TABLE `auth_user` MODIFY `last_login` datetime(6) NULL;
COMMIT;


# auth 0006_require_contenttypes_0002


# my_storage 0001_initial
BEGIN;
CREATE TABLE `my_storage_comments` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `comment` varchar(2000) NOT NULL, `resource_id` integer NOT NULL, `date` datetime(6) NOT NULL);
CREATE TABLE `my_storage_likesdislikes` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `resource_id` integer NOT NULL, `like` bool NOT NULL, `dislike` bool NOT NULL);
CREATE TABLE `my_storage_links` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `link_name` varchar(100) NOT NULL, `link` varchar(2000) NOT NULL, `date` datetime(6) NOT NULL);
CREATE TABLE `my_storage_notes` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `topic` varchar(100) NOT NULL, `body` longtext NOT NULL, `private` bool NOT NULL, `date` datetime(6) NOT NULL);
CREATE TABLE `my_storage_subjects` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `name` varchar(50) NOT NULL);
CREATE TABLE `my_storage_typetable` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `type_name` varchar(100) NOT NULL);
CREATE TABLE `my_storage_userprofile` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `time_zone` varchar(50) NOT NULL, `user_id` integer NOT NULL);
ALTER TABLE `my_storage_notes` ADD COLUMN `subject_id` integer NOT NULL;
ALTER TABLE `my_storage_notes` ALTER COLUMN `subject_id` DROP DEFAULT;
ALTER TABLE `my_storage_notes` ADD COLUMN `user_id` integer NOT NULL;
ALTER TABLE `my_storage_notes` ALTER COLUMN `user_id` DROP DEFAULT;
ALTER TABLE `my_storage_links` ADD COLUMN `subject_id` integer NOT NULL;
ALTER TABLE `my_storage_links` ALTER COLUMN `subject_id` DROP DEFAULT;
ALTER TABLE `my_storage_links` ADD COLUMN `type_id` integer NOT NULL;
ALTER TABLE `my_storage_links` ALTER COLUMN `type_id` DROP DEFAULT;
ALTER TABLE `my_storage_links` ADD COLUMN `user_id` integer NOT NULL;
ALTER TABLE `my_storage_links` ALTER COLUMN `user_id` DROP DEFAULT;
ALTER TABLE `my_storage_likesdislikes` ADD COLUMN `type_id` integer NOT NULL;
ALTER TABLE `my_storage_likesdislikes` ALTER COLUMN `type_id` DROP DEFAULT;
ALTER TABLE `my_storage_likesdislikes` ADD COLUMN `user_id` integer NOT NULL;
ALTER TABLE `my_storage_likesdislikes` ALTER COLUMN `user_id` DROP DEFAULT;
ALTER TABLE `my_storage_comments` ADD COLUMN `type_id` integer NOT NULL;
ALTER TABLE `my_storage_comments` ALTER COLUMN `type_id` DROP DEFAULT;
ALTER TABLE `my_storage_comments` ADD COLUMN `user_id` integer NOT NULL;
ALTER TABLE `my_storage_comments` ALTER COLUMN `user_id` DROP DEFAULT;
ALTER TABLE `my_storage_userprofile` ADD CONSTRAINT `my_storage_userprofile_user_id_71054f50_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);
CREATE INDEX `my_storage_notes_ffaba1d1` ON `my_storage_notes` (`subject_id`);
ALTER TABLE `my_storage_notes` ADD CONSTRAINT `my_storage_notes_subject_id_606910f7_fk_my_storage_subjects_id` FOREIGN KEY (`subject_id`) REFERENCES `my_storage_subjects` (`id`);
CREATE INDEX `my_storage_notes_e8701ad4` ON `my_storage_notes` (`user_id`);
ALTER TABLE `my_storage_notes` ADD CONSTRAINT `my_storage_notes_user_id_6532d355_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);
CREATE INDEX `my_storage_links_ffaba1d1` ON `my_storage_links` (`subject_id`);
ALTER TABLE `my_storage_links` ADD CONSTRAINT `my_storage_links_subject_id_4acf76db_fk_my_storage_subjects_id` FOREIGN KEY (`subject_id`) REFERENCES `my_storage_subjects` (`id`);
CREATE INDEX `my_storage_links_94757cae` ON `my_storage_links` (`type_id`);
ALTER TABLE `my_storage_links` ADD CONSTRAINT `my_storage_links_type_id_32fd4c_fk_my_storage_typetable_id` FOREIGN KEY (`type_id`) REFERENCES `my_storage_typetable` (`id`);
CREATE INDEX `my_storage_links_e8701ad4` ON `my_storage_links` (`user_id`);
ALTER TABLE `my_storage_links` ADD CONSTRAINT `my_storage_links_user_id_66e9d3f1_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);
CREATE INDEX `my_storage_likesdislikes_94757cae` ON `my_storage_likesdislikes` (`type_id`);
ALTER TABLE `my_storage_likesdislikes` ADD CONSTRAINT `my_storage_likesdisl_type_id_166d952d_fk_my_storage_typetable_id` FOREIGN KEY (`type_id`) REFERENCES `my_storage_typetable` (`id`);
CREATE INDEX `my_storage_likesdislikes_e8701ad4` ON `my_storage_likesdislikes` (`user_id`);
ALTER TABLE `my_storage_likesdislikes` ADD CONSTRAINT `my_storage_likesdislikes_user_id_6fa0b3f6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);
CREATE INDEX `my_storage_comments_94757cae` ON `my_storage_comments` (`type_id`);
ALTER TABLE `my_storage_comments` ADD CONSTRAINT `my_storage_comments_type_id_1029a7a0_fk_my_storage_typetable_id` FOREIGN KEY (`type_id`) REFERENCES `my_storage_typetable` (`id`);
CREATE INDEX `my_storage_comments_e8701ad4` ON `my_storage_comments` (`user_id`);
ALTER TABLE `my_storage_comments` ADD CONSTRAINT `my_storage_comments_user_id_4fdcfa3_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);
COMMIT;


# sessions 0001_initial
BEGIN;
CREATE TABLE `django_session` (`session_key` varchar(40) NOT NULL PRIMARY KEY, `session_data` longtext NOT NULL, `expire_date` datetime(6) NOT NULL);
CREATE INDEX `django_session_de54fa62` ON `django_session` (`expire_date`);
COMMIT;

