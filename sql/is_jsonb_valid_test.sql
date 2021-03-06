CREATE EXTENSION is_jsonb_valid;
select is_jsonb_valid(NULL, NULL);
select is_jsonb_valid(NULL, '{}');
SELECT is_jsonb_valid('{}', '{}');
select is_jsonb_valid('{"not": {"type": "object"}}', '1');
select is_jsonb_valid('{"not": {"type": "object"}}', '{}');
SELECT is_jsonb_valid('{"type": "object"}', '{}');
SELECT is_jsonb_valid('{"type": "object"}', '2');
SELECT is_jsonb_valid('{"type": "object"}', '{"a": 1}');
SELECT is_jsonb_valid('{"type": "number"}', '2');
SELECT is_jsonb_valid('{"type": "integer"}', '2');
select is_jsonb_valid('{"enum": [ 1, 2, 3, {"a": 2}]}', '1');
select is_jsonb_valid('{"enum": [ 1, 2, 3, {"a": 2}]}', '{"a": 2}');
select is_jsonb_valid('{"enum": [ 1, 2, 3, {"a": 2}]}', '{"a": 1}');
select is_jsonb_valid('{"minLength": 2}', '"abc"');
select is_jsonb_valid('{"minLength": 2}', '"a"');
select is_jsonb_valid('{"maxLength": 2}', '"a"');
select is_jsonb_valid('{"maxLength": 2}', '"abc"');
select is_jsonb_valid('{
                           "dependencies": {
                               "a": {
                                   "properties": {
                                       "x": { "type": "integer" }
                                   }
                               }
                           }
                       }', '{
                                "a": "whatever",
                                "x": 131
                            }');
select is_jsonb_valid('{
                           "dependencies": {
                               "a": {
                                   "properties": {
                                       "x": { "type": "integer" }
                                   }
                               }
                           }
                       }', '{
                                "a": true,
                                "x": 1.1
                            }');
select is_jsonb_valid('{
                           "dependencies": {
                               "a": "b",
                               "c": [ "d", "e" ]
                           }
                       }', '{
                               "a": true,
                               "b": null
                           }');
select is_jsonb_valid('{
                           "dependencies": {
                               "a": "b",
                               "c": [ "d", "e" ]
                           }
                       }', '{
                                "c": false,
                                "d": 31
                            }');
select is_jsonb_valid('{
                           "dependencies": {
                               "a": "b",
                               "c": [ "d", "e" ]
                           }
                       }', '{
                                "c": false,
                                "d": 31,
                                "e": {"a": 1}
                            }');
select is_jsonb_valid('{
                                   "patternProperties": {
                                       "f.*o": {"type": "integer"}
                                   }}', '{"foo": 1}');
select is_jsonb_valid('{
                                   "patternProperties": {
                                       "f.*o": {"type": "integer"}
                                   }}', '{"foo": "bar", "fooooo": 2}');
select is_jsonb_valid('{
                                                         "patternProperties": {
                                                             "f.*o": {"type": "integer"}
                                                         }, "properties": {"a": {"type": "integer"}}, "additionalProperties": false}', '{"foo": 1, "a": 2.5}');
select is_jsonb_valid('{
                                                         "patternProperties": {
                                                             "f.*o": {"type": "integer"}
                                                         }, "properties": {"a": {"type": "integer"}}, "additionalProperties": false}', '{"foo": 1, "a": 2}');
select is_jsonb_valid('{
                                                         "patternProperties": {
                                                             "f.*o": {"type": "integer"}
                                                         }, "properties": {"a": {"type": "integer"}}, "additionalProperties": true}', '{"foo": 1, "a": 2}');
select is_jsonb_valid('{
                                                         "patternProperties": {
                                                             "f.*o": {"type": "integer"}
                                                         }, "properties": {"a": {"type": "integer"}}, "additionalProperties": true}', '{"foo": 1, "a": 2, "b": false}');
select is_jsonb_valid('{
                                                         "patternProperties": {
                                                             "f.*o": {"type": "integer"}
                                                         }, "properties": {"a": {"type": "integer"}}, "additionalProperties": {"type": "boolean"}}', '{"foo": 1, "a": 2, "b": false}');
select is_jsonb_valid('{
                                                         "patternProperties": {
                                                             "f.*o": {"type": "integer"}
                                                         }, "properties": {"a": {"type": "integer"}}, "additionalProperties": {"type": "number"}}', '{"foo": 1, "a": 2, "b": false}');


select is_jsonb_valid('{"multipleOf": 2}', '4');
select is_jsonb_valid('{"multipleOf": 1.5}', '4.5');
select is_jsonb_valid('{"multipleOf": 4.5}', '2');
select is_jsonb_valid('{"pattern": "a"}', '"a"');
select is_jsonb_valid('{"pattern": "[Ss]mith"}', '"My blacksmith produces excellent steel"');
select is_jsonb_valid('{"pattern": "[Ss]mith"}', '"I am no good at smitking, I''m afraid"');
select is_jsonb_valid('{"maxItems": 5}', '[1, 2, 3, 4]');
select is_jsonb_valid('{"maxItems": 2}', '[1, 2, 3, 4]');
select is_jsonb_valid('{"minItems": 1}', '[1, {"bc": 2}, 3, 4]');
select is_jsonb_valid('{"minItems": 5}', '[{"a": 1}, 2, 3, 4]');
select is_jsonb_valid('{"maxProperties": 4}', '"dab"');
select is_jsonb_valid('{"maxProperties": 4}', '{"a": 1, "b": 4, "c": 4, "d": 67, "e": 91}');
select is_jsonb_valid('{"minProperties": 4}', '{"a": 1, "b": 4, "c": 4, "d": 67, "e": 91}');
select is_jsonb_valid('{"minProperties": 6}', '{"a": 1, "b": 4, "c": 4, "d": 67, "e": 91}');
SELECT is_jsonb_valid('{"anyOf": [{"type": "number"}, {"type": "integer"}]}', '2');
SELECT is_jsonb_valid('{"allOf": [{"type": "number"}, {"type": "integer"}]}', '2');
SELECT is_jsonb_valid('{"oneOf": [{"type": "number"}, {"type": "integer"}]}', '2');
SELECT is_jsonb_valid('{"minimum": 3}', '2');
SELECT is_jsonb_valid('{"minimum": 1}', '2');
select is_jsonb_valid('{"uniqueItems": true}', '[1, 2, 3]');
select is_jsonb_valid('{"uniqueItems": false}', '[1, 2, 2]');
select is_jsonb_valid('{"uniqueItems": true}', '[1, 2, 2]');
select is_jsonb_valid('{"uniqueItems": true}', '[1, {"a": {"b": 1}}, {"a": {"b": 1}}]');
select is_jsonb_valid('{"uniqueItems": true}', '[1, {"a": {"b": 1}}, {"a": {"b": 2}}]');
SELECT is_jsonb_valid('{"minimum": 2}', '2');
SELECT is_jsonb_valid('{"minimum": 2, "exclusiveMinimum": true}', '2');
SELECT is_jsonb_valid('{"maximum": 3}', '2');
SELECT is_jsonb_valid('{"maximum": 1}', '2');
SELECT is_jsonb_valid('{"maximum": 2}', '2');
SELECT is_jsonb_valid('{"maximum": 2, "exclusiveMaximum": true}', '2');
SELECT is_jsonb_valid('{"type": "integer"}', '2');
SELECT is_jsonb_valid('{"type": ["integer"]}', '2');
SELECT is_jsonb_valid('{"type": ["string", "integer"]}', '2');
SELECT is_jsonb_valid('{"type": ["string", ["integer", "string"]]}', '2');
SELECT is_jsonb_valid('{"type": ["null", "string"]}', '2');
SELECT is_jsonb_valid('{"type": ["null", {"type": "integer"}]}', '2');

SELECT is_jsonb_valid('{"type": "integer"}', '2.5');
SELECT is_jsonb_valid('{"properties": {}}', '2.5');
SELECT is_jsonb_valid('{"properties": {"a": {"type": "null"}}}', '{"a": 1}');
SELECT is_jsonb_valid('{"properties": {"a": {"type": "integer"}}, "additionalProperties": false}', '{"a": 1, "b": 5}');
SELECT is_jsonb_valid('{"properties": {"a": {"type": "integer"}}, "additionalProperties": true}', '{"a": 1, "b": 5}');
SELECT is_jsonb_valid('{"properties": {"a": {"type": "integer"}}, "additionalProperties": {"type": "boolean"}}', '{"a": 1, "b": 5}');
SELECT is_jsonb_valid('{"properties": {"a": {"type": "integer"}}, "additionalProperties": {"type": "number"}}', '{"a": 1, "b": 5}');
SELECT is_jsonb_valid('{"properties": {"a": {"type": "number"}}}', '{"a": 2.5}');
SELECT is_jsonb_valid('{"properties": {"a": {"type": "integer"}}}', '{"a": 2}');
SELECT is_jsonb_valid('{"properties": {"a": {"type": "integer"}}}', '{"a": 2.5}');
--- property is compared with length of key, in this case 4
SELECT is_jsonb_valid('{"properties": {"a": {"type": "inte"}}}', '{"a": 2}');
SELECT is_jsonb_valid('{"properties": {"a": {"required": true}}}', '{}');
SELECT is_jsonb_valid('{"properties": {"a": {"required": false}}}', '{}');
SELECT is_jsonb_valid('{"properties": {"a": {"required": true}}}', '{"a": 1}');
SELECT is_jsonb_valid('{"required": ["a", "b"]}', '{"a": 1}');
SELECT is_jsonb_valid('{"required": ["a", "b"]}', '{"a": 1, "b": 2}');
SELECT is_jsonb_valid('{"required": ["a", "b"]}', '1');
select is_jsonb_valid('{"items": [{"type": "integer"}, {"type": "number"}]}', '[1, 2.5, 3.5]');
select is_jsonb_valid('{"items": {"type": "integer"}}', '[1, 2, 3]');
select is_jsonb_valid('{"items": {"type": "integer"}}', '[1, 2, 3.5]');
select is_jsonb_valid('{"items": [{"type": "integer"}, {"type": "number"}], "additionalItems": false}', '[1, 2.5, 3.5]');
select is_jsonb_valid('{"items": [{"type": "integer"}, {"type": "number"}], "additionalItems": {"type": "string"}}', '[1, 2.5, 3.5]');
select is_jsonb_valid('{"items": [{"type": "integer"}, {"type": "number"}], "additionalItems": {"type": "number"}}', '[1, 2.5, 3.5]');
SELECT is_jsonb_valid('{"properties": {"a": {"type": "integer"}}}', '{"b": 1}');

SELECT is_jsonb_valid('{"type": 1}', '2');
