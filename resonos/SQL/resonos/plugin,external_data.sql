INSERT INTO `plugin` (`id`, `name`, `enabled`, `config_json`, `created_at`) VALUES
(1, 'Plugin A', TRUE, '{"setting1": "value1", "setting2": "value2"}', '2025-06-10 09:00:00'),
(2, 'Plugin B', FALSE, '{"setting1": "value1", "setting2": "value2"}', '2025-06-11 10:15:00'),
(3, 'Plugin C', TRUE, '{"setting1": "value3", "setting2": "value4"}', '2025-06-12 11:30:00'),
(4, 'Plugin D', TRUE, '{"setting1": "value5", "setting2": "value6"}', '2025-06-13 12:45:00'),
(5, 'Plugin E', FALSE, '{"setting1": "value7", "setting2": "value8"}', '2025-06-14 14:00:00'),
(6, 'Plugin F', TRUE, '{"setting1": "value9", "setting2": "value10"}', '2025-06-15 15:30:00'),
(7, 'Plugin G', FALSE, '{"setting1": "value11", "setting2": "value12"}', '2025-06-16 16:45:00'),
(8, 'Plugin H', TRUE, '{"setting1": "value13", "setting2": "value14"}', '2025-06-17 18:00:00'),
(9, 'Plugin I', TRUE, '{"setting1": "value15", "setting2": "value16"}', '2025-06-18 19:15:00'),
(10, 'Plugin J', FALSE, '{"setting1": "value17", "setting2": "value18"}', '2025-06-19 20:30:00');

INSERT INTO `external_api_config` (`id`, `provider`, `apiKey`, `secret`, `enabled`, `created_at`) VALUES
(1, 'Google API', 'api_key_1', 'secret_key_1', TRUE, '2025-06-10 09:00:00'),
(2, 'Facebook API', 'api_key_2', 'secret_key_2', FALSE, '2025-06-11 10:15:00'),
(3, 'Twitter API', 'api_key_3', 'secret_key_3', TRUE, '2025-06-12 11:30:00'),
(4, 'GitHub API', 'api_key_4', 'secret_key_4', TRUE, '2025-06-13 12:45:00'),
(5, 'Spotify API', 'api_key_5', 'secret_key_5', FALSE, '2025-06-14 14:00:00'),
(6, 'Instagram API', 'api_key_6', 'secret_key_6', TRUE, '2025-06-15 15:30:00'),
(7, 'YouTube API', 'api_key_7', 'secret_key_7', FALSE, '2025-06-16 16:45:00'),
(8, 'LinkedIn API', 'api_key_8', 'secret_key_8', TRUE, '2025-06-17 18:00:00'),
(9, 'Slack API', 'api_key_9', 'secret_key_9', TRUE, '2025-06-18 19:15:00'),
(10, 'PayPal API', 'api_key_10', 'secret_key_10', FALSE, '2025-06-19 20:30:00');
