GDPC                                                                                   res://Assets/ui/witchavatar.png `e      	      ����e$v���7�R0   res://Builds/Build3/Narrative/Level1/Test.json  @
      �      �d^�(��ʂ�LE�4   res://Builds/Build3/Narrative/Level1/choices.json   �      B       �J�7�xt��.KJ� �0   res://Builds/Build3/Narrative/Level1/events.json0      E      ̮�������f�"o4   res://Builds/Build3/Narrative/Level1/inventory.json �             ��.���̲���t��0   res://Builds/Build4/Narrative/Level1/Test.json  �      �      ��`�c9J�Ԏ�!�4   res://Builds/Build4/Narrative/Level1/choices.json   @      B       �J�7�xt��.KJ� �0   res://Builds/Build4/Narrative/Level1/events.json�      �      Hz�c���5��fM��4   res://Builds/Build4/Narrative/Level1/inventory.json `             ��.���̲���t��0   res://Builds/Build5/Narrative/Level1/Test.json  �      )      ��t�Ԑ�9ɗ� l4   res://Builds/Build5/Narrative/Level1/choices.json   �!      B       �J�7�xt��.KJ� �0   res://Builds/Build5/Narrative/Level1/events.json "      �      Hz�c���5��fM��4   res://Builds/Build5/Narrative/Level1/inventory.json �$      Z       �"8�[�c�5�8kq�0   res://Builds/Build6/Narrative/Level1/Test.json  0%      
      �g�
�	���k�oC5/4   res://Builds/Build6/Narrative/Level1/choices.json   @/      B       �J�7�xt��.KJ� �0   res://Builds/Build6/Narrative/Level1/events.json�/      �      �;d�D&W�6R���4   res://Builds/Build6/Narrative/Level1/inventory.json P3      Y       �5�D�A����v�0   res://Builds/Build7/Narrative/Level1/Test.json  �3      
      �g�
�	���k�oC5/4   res://Builds/Build7/Narrative/Level1/choices.json   �=      B       �J�7�xt��.KJ� �0   res://Builds/Build7/Narrative/Level1/events.json>      �      �;d�D&W�6R���4   res://Builds/Build7/Narrative/Level1/inventory.json �A      Y       �5�D�A����v�0   res://Builds/Build8/Narrative/Level1/Test.json  0B      �      &ti�H��+���ޕ�4   res://Builds/Build8/Narrative/Level1/choices.json   �N      A       ��~	��"����8Ң0   res://Builds/Build8/Narrative/Level1/events.json@O      �      �s� ��:��>Z�=��g4   res://Builds/Build8/Narrative/Level1/inventory.json  S      Y       �5�D�A����v�    res://Narrative/Level1/Test.json`S      �      &ti�H��+���ޕ�$   res://Narrative/Level1/choices.json  `      A       ��~	��"����8Ң$   res://Narrative/Level1/events.json  p`      �      �s� ��:��>Z�=��g(   res://Narrative/Level1/inventory.json   0d      Y       �5�D�A����v�   res://dialouge.json �d      �       /NX���7q��a�_=   res://project.binarypj      3"      RϘ�S�t�h�w?\    {
    "data": {
        "doorInitial": {
            "0": {
                "content": [
                    "I shouldn't leave until I get my first soul..",
                    {
                        "isEnd": true
                    }
                ]
            },
            "initial": "0"
        },
        "doorUnlocked" : {
            "0": {
                "content": [
                    "You unlocked the door!",
                    {
                        "isEnd": true
                    }
                ]
            },
            "initial": "0"
        },
        "bookInspect" : {
            "0" : {
                "content" : [
                   "Do they really expect me to read all these books?",
                   {
                        "isEnd": true        
				   }
				]     
			},
            "initial": "0"
		},
        "bookInspectRepeat" : {
            "0" : {
                "content" : [
                   "Yea I aint reading all of these...",
                   {
                        "isEnd": true        
				   }
				]     
			},
            "initial": "0"
		}
    }
}         {
"talkedNPC1": false,
"readBooks": false,
"hasStone": false
}              {
    "SceneName": "Level1",
    "eventTarget": {
        "Object_Door": {
            "Start": {
                "Name": "doorInitial",
                "Flag": false
            },
            "Unlock" : {
                "Name": "doorUnlocked",
                "Flag": "hasStone"
            }
        },
        "Object_Bookstack" : {
            "Start" : {
                "Name" : "bookInspect",
                "Flag" : false
			},
            "Repeat" : {
                "Name" : "bookInspectRepeat",
                "Flag" : false
			}
		}
    }
}           {
    "items": []
}           {
    "data": {
        "doorInitial": {
            "0": {
                "content": [
                    "I shouldn't leave until I get my first soul..",
                    {
                        "isEnd": true
                    }
                ]
            },
            "initial": "0"
        },
        "npc1": {
            "0": {
                "content": [
                    "hello!",
                    {
                        "isEnd": true
                    }
                ]
            },
            "initial": "0"
        },
        "doorUnlocked" : {
            "0": {
                "content": [
                    "You unlocked the door!",
                    {
                        "isEnd": true
                    }
                ]
            },
            "initial": "0"
        },
        "bookInspect" : {
            "0" : {
                "content" : [
                   "Do they really expect me to read all these books?",
                   {
                        "isEnd": true        
				   }
				]     
			},
            "initial": "0"
		},
        "bookInspectRepeat" : {
            "0" : {
                "content" : [
                   "Yea I aint reading all of these...",
                   {
                        "isEnd": true        
				   }
				]     
			},
            "initial": "0"
		}
    }
}     {
"talkedNPC1": false,
"readBooks": false,
"hasStone": false
}              {
    "SceneName": "Level1",
    "eventTarget": {
        "Object_Door": {
            "Start": {
                "Name": "doorInitial",
                "Flag": false
            },
            "Unlock" : {
                "Name": "doorUnlocked",
                "Flag": "hasStone"
            }
        },
        "NPC1": {
            "Start": {
                "Name": "npc1",
                "Flag": false
            }
        },
        "Object_Bookstack" : {
            "Start" : {
                "Name" : "bookInspect",
                "Flag" : false
			},
            "Repeat" : {
                "Name" : "bookInspectRepeat",
                "Flag" : false
			}
		}
    }
}     {
    "items": []
}           {
    "data": {
        "doorInitial": {
            "0": {
                "content": [
                    "I shouldn't leave until I get my first soul..",
                    {
                        "isEnd": true
                    },
                    {
                        "expression": "witch_stare"           
					}
                ]
            },
            "initial": "0"
        },
        "npc1": {
            "0": {
                "content": [
                    "hello!",
                    {
                        "divert": "1"
                    },
                    {
                        "expression": "npc1_happy"           
					}
                ]
            },
            "1":{
                "content": [
                    "Hi!!",
                    {
                        "isEnd": true           
					},
                    {
                        "expression": "witch_happy"           
					}
				]     
			},
            "initial": "0"
        },
        "bookInspect" : {
            "0" : {
                "content" : [
                   "Do they really expect me to read all these books?",
                   {
                        "isEnd": true        
                    },
                    {
                        "expression": "witch_stare"           
					}
				]     
			},
            "initial": "0"
		},
        "bookInspectRepeat" : {
            "0" : {
                "content" : [
                   "Yea I aint reading all of these...",
                   {
                        "isEnd": true        
                    },
                    {
                        "expression": "witch_stare"           
					}
				]     
			},
            "initial": "0"
		}
    }
}       {
"talkedNPC1": false,
"readBooks": false,
"hasStone": false
}              {
    "SceneName": "Level1",
    "eventTarget": {
        "Object_Door": {
            "Start": {
                "Name": "doorInitial",
                "Flag": false
            },
            "Unlock" : {
                "Name": "doorUnlocked",
                "Flag": "hasStone"
            }
        },
        "NPC1": {
            "Start": {
                "Name": "npc1",
                "Flag": false
            }
        },
        "Object_Bookstack" : {
            "Start" : {
                "Name" : "bookInspect",
                "Flag" : false
			},
            "Repeat" : {
                "Name" : "bookInspectRepeat",
                "Flag" : false
			}
		}
    }
}     {
    "items": [
        "glasses",
        "phone",
        "null"
             ]
}      {
    "data": {
        "soulInitial": {
            "0": {
                "content": [
                    "How do I collect this thing?",
                    {
                        "isEnd": true           
					},
                    {
                        "expression": "witch_stare"           
					}
				]     
			},
            "initial": "0"
		},
        "soulRepeat": {
            "0": {
                "content": [
                    "Oh yea I think I'm suppose to use my phone!",
                    {
                        "isEnd": true           
					},
                    {
                        "expression": "witch_happy"           
					}
				]     
			},
            "initial": "0"
		},
        "doorInitial": {
            "0": {
                "content": [
                    "I shouldn't leave until I get my first soul..",
                    {
                        "isEnd": true
                    },
                    {
                        "expression": "witch_stare"           
					}
                ]
            },
            "initial": "0"
        },
        "npc1": {
            "0": {
                "content": [
                    "hello!",
                    {
                        "divert": "1"
                    },
                    {
                        "expression": "npc1_happy"           
					}
                ]
            },
            "1":{
                "content": [
                    "Hi!!",
                    {
                        "isEnd": true           
					},
                    {
                        "expression": "witch_happy"           
					}
				]     
			},
            "initial": "0"
        },
        "bookInspect" : {
            "0" : {
                "content" : [
                   "Do they really expect me to read all these books?",
                   {
                        "isEnd": true        
                    },
                    {
                        "expression": "witch_stare"           
					}
				]     
			},
            "initial": "0"
		},
        "bookInspectRepeat" : {
            "0" : {
                "content" : [
                   "Yea I aint reading all of these...",
                   {
                        "isEnd": true        
                    },
                    {
                        "expression": "witch_stare"           
					}
				]     
			},
            "initial": "0"
		}
    }
}           {
"talkedNPC1": false,
"readBooks": false,
"hasStone": false
}              {
    "SceneName": "Level1",
    "eventTarget": {
        "Object_Door": {
            "Start": {
                "Name": "doorInitial",
                "Flag": false
            },
            "Unlock" : {
                "Name": "doorUnlocked",
                "Flag": "hasStone"
            }
        },
        "NPC1": {
            "Start": {
                "Name": "npc1",
                "Flag": false
            }
        },
        "Object_Bookstack" : {
            "Start" : {
                "Name" : "bookInspect",
                "Flag" : false
			},
            "Repeat" : {
                "Name" : "bookInspectRepeat",
                "Flag" : false
			}
		},
        "Soul": {
            "Start" : {
                "Name" : "soulInitial",
                "Flag" : false
			},
            "Repeat" : {
                "Name" : "soulRepeat",
                "Flag" : false
			}
        }
    }
}     {
    "items": [
        "glasses",
        "null",
        "null"
             ]
}       {
    "data": {
        "soulInitial": {
            "0": {
                "content": [
                    "How do I collect this thing?",
                    {
                        "isEnd": true           
					},
                    {
                        "expression": "witch_stare"           
					}
				]     
			},
            "initial": "0"
		},
        "soulRepeat": {
            "0": {
                "content": [
                    "Oh yea I think I'm suppose to use my phone!",
                    {
                        "isEnd": true           
					},
                    {
                        "expression": "witch_happy"           
					}
				]     
			},
            "initial": "0"
		},
        "doorInitial": {
            "0": {
                "content": [
                    "I shouldn't leave until I get my first soul..",
                    {
                        "isEnd": true
                    },
                    {
                        "expression": "witch_stare"           
					}
                ]
            },
            "initial": "0"
        },
        "npc1": {
            "0": {
                "content": [
                    "hello!",
                    {
                        "divert": "1"
                    },
                    {
                        "expression": "npc1_happy"           
					}
                ]
            },
            "1":{
                "content": [
                    "Hi!!",
                    {
                        "isEnd": true           
					},
                    {
                        "expression": "witch_happy"           
					}
				]     
			},
            "initial": "0"
        },
        "bookInspect" : {
            "0" : {
                "content" : [
                   "Do they really expect me to read all these books?",
                   {
                        "isEnd": true        
                    },
                    {
                        "expression": "witch_stare"           
					}
				]     
			},
            "initial": "0"
		},
        "bookInspectRepeat" : {
            "0" : {
                "content" : [
                   "Yea I aint reading all of these...",
                   {
                        "isEnd": true        
                    },
                    {
                        "expression": "witch_stare"           
					}
				]     
			},
            "initial": "0"
		}
    }
}           {
"talkedNPC1": false,
"readBooks": false,
"hasStone": false
}              {
    "SceneName": "Level1",
    "eventTarget": {
        "Object_Door": {
            "Start": {
                "Name": "doorInitial",
                "Flag": false
            },
            "Unlock" : {
                "Name": "doorUnlocked",
                "Flag": "hasStone"
            }
        },
        "NPC1": {
            "Start": {
                "Name": "npc1",
                "Flag": false
            }
        },
        "Object_Bookstack" : {
            "Start" : {
                "Name" : "bookInspect",
                "Flag" : false
			},
            "Repeat" : {
                "Name" : "bookInspectRepeat",
                "Flag" : false
			}
		},
        "Soul": {
            "Start" : {
                "Name" : "soulInitial",
                "Flag" : false
			},
            "Repeat" : {
                "Name" : "soulRepeat",
                "Flag" : false
			}
        }
    }
}     {
    "items": [
        "glasses",
        "null",
        "null"
             ]
}       {
    "data": {
        "soulInitial": {
            "0": {
                "content": [
                    "How do I collect this thing?",
                    {
                        "isEnd": true           
					},
                    {
                        "expression": "witch_stare"           
					}
				]     
			},
            "initial": "0"
		},
        "soulRepeat": {
            "0": {
                "content": [
                    "Oh yea I think I'm suppose to use my phone!",
                    {
                        "isEnd": true           
					},
                    {
                        "expression": "witch_happy"           
					}
				]     
			},
            "initial": "0"
		},
        "doorInitial": {
            "0": {
                "content": [
                    "I shouldn't leave until I get my first soul..",
                    {
                        "isEnd": true
                    },
                    {
                        "expression": "witch_stare"           
					}
                ]
            },
            "initial": "0"
        },
        "doorUnlocked": {
            "0" : {
                "content" : [
                    "I'm ready to explore the world with my new Soul now!",
                    {
                        "divert": "1"           
					},
                    {
                        "expression": "witch_happy"           
					}
				]     
			},
            "1":{
                "content": [
                    "If only SOMEONE would code it...",
                    {
                        "isEnd" : true           
					},
                    {
                        "expression" : "witch_stare"           
					}
				]     
			},
            "initial": "0"
		},
        "npc1": {
            "0": {
                "content": [
                    "hello!",
                    {
                        "divert": "1"
                    },
                    {
                        "expression": "npc1_happy"           
					}
                ]
            },
            "1":{
                "content": [
                    "Hi!!",
                    {
                        "isEnd": true           
					},
                    {
                        "expression": "witch_happy"           
					}
				]     
			},
            "initial": "0"
        },
        "bookInspect" : {
            "0" : {
                "content" : [
                   "Do they really expect me to read all these books?",
                   {
                        "isEnd": true        
                    },
                    {
                        "expression": "witch_stare"           
					}
				]     
			},
            "initial": "0"
		},
        "bookInspectRepeat" : {
            "0" : {
                "content" : [
                   "Yea I aint reading all of these...",
                   {
                        "isEnd": true        
                    },
                    {
                        "expression": "witch_stare"           
					}
				]     
			},
            "initial": "0"
		}
    }
}         {
"talkedNPC1": false,
"readBooks": false,
"hasSoul": false
}               {
    "SceneName": "Level1",
    "eventTarget": {
        "Object_Door": {
            "Start": {
                "Name": "doorInitial",
                "Flag": false
            },
            "Unlock" : {
                "Name": "doorUnlocked",
                "Flag": "hasSoul"
            }
        },
        "NPC1": {
            "Start": {
                "Name": "npc1",
                "Flag": false
            }
        },
        "Object_Bookstack" : {
            "Start" : {
                "Name" : "bookInspect",
                "Flag" : false
			},
            "Repeat" : {
                "Name" : "bookInspectRepeat",
                "Flag" : false
			}
		},
        "Soul": {
            "Start" : {
                "Name" : "soulInitial",
                "Flag" : false
			},
            "Repeat" : {
                "Name" : "soulRepeat",
                "Flag" : false
			}
        }
    }
}      {
    "items": [
        "glasses",
        "null",
        "null"
             ]
}       {
    "data": {
        "soulInitial": {
            "0": {
                "content": [
                    "How do I collect this thing?",
                    {
                        "isEnd": true           
					},
                    {
                        "expression": "witch_stare"           
					}
				]     
			},
            "initial": "0"
		},
        "soulRepeat": {
            "0": {
                "content": [
                    "Oh yea I think I'm suppose to use my phone!",
                    {
                        "isEnd": true           
					},
                    {
                        "expression": "witch_happy"           
					}
				]     
			},
            "initial": "0"
		},
        "doorInitial": {
            "0": {
                "content": [
                    "I shouldn't leave until I get my first soul..",
                    {
                        "isEnd": true
                    },
                    {
                        "expression": "witch_stare"           
					}
                ]
            },
            "initial": "0"
        },
        "doorUnlocked": {
            "0" : {
                "content" : [
                    "I'm ready to explore the world with my new Soul now!",
                    {
                        "divert": "1"           
					},
                    {
                        "expression": "witch_happy"           
					}
				]     
			},
            "1":{
                "content": [
                    "If only SOMEONE would code it...",
                    {
                        "isEnd" : true           
					},
                    {
                        "expression" : "witch_stare"           
					}
				]     
			},
            "initial": "0"
		},
        "npc1": {
            "0": {
                "content": [
                    "hello!",
                    {
                        "divert": "1"
                    },
                    {
                        "expression": "npc1_happy"           
					}
                ]
            },
            "1":{
                "content": [
                    "Hi!!",
                    {
                        "isEnd": true           
					},
                    {
                        "expression": "witch_happy"           
					}
				]     
			},
            "initial": "0"
        },
        "bookInspect" : {
            "0" : {
                "content" : [
                   "Do they really expect me to read all these books?",
                   {
                        "isEnd": true        
                    },
                    {
                        "expression": "witch_stare"           
					}
				]     
			},
            "initial": "0"
		},
        "bookInspectRepeat" : {
            "0" : {
                "content" : [
                   "Yea I aint reading all of these...",
                   {
                        "isEnd": true        
                    },
                    {
                        "expression": "witch_stare"           
					}
				]     
			},
            "initial": "0"
		}
    }
}         {
"talkedNPC1": false,
"readBooks": false,
"hasSoul": false
}               {
    "SceneName": "Level1",
    "eventTarget": {
        "Object_Door": {
            "Start": {
                "Name": "doorInitial",
                "Flag": false
            },
            "Unlock" : {
                "Name": "doorUnlocked",
                "Flag": "hasSoul"
            }
        },
        "NPC1": {
            "Start": {
                "Name": "npc1",
                "Flag": false
            }
        },
        "Object_Bookstack" : {
            "Start" : {
                "Name" : "bookInspect",
                "Flag" : false
			},
            "Repeat" : {
                "Name" : "bookInspectRepeat",
                "Flag" : false
			}
		},
        "Soul": {
            "Start" : {
                "Name" : "soulInitial",
                "Flag" : false
			},
            "Repeat" : {
                "Name" : "soulRepeat",
                "Flag" : false
			}
        }
    }
}      {
    "items": [
        "glasses",
        "null",
        "null"
             ]
}       "001" : {"name":"NPC1", "expression": "neutral", "text":"Have you finished your studies yet?" }
"002" : {"name":"NPC2", "expression": "neutral", "text":"Wow, you don't even have your witch's stone do you?" }�PNG

   IHDR   <   I   aE   �IDATx��[��9��!e�6�"�{F�xu1�G>B��]|"�`W"E�+�K"��L���v��e����I��vUu}�r���1cƌ3f̘�k@ ���o�Փ����T��� "Tz�^9G<PY��4�)��}��tz���s��[�|NJ�c�1m�It	��.�0Y����O�q�����ꉃ1��k�4�l�!F��l	���Q�L�ق��d��B�Sa$���I��d�u㐝j���	��ɞ��E��pt�@?͇�]��[Uѕ���]��G�H���q�tv*�^���z��ݽS�Emӛ�s��I��.�)ec~��K!�k���6�)��n5��T������u�+A�|̎�D��9Y�`f�VC����z	��0hd��g�J4kk[�s���W()�������_�c���t�M���,��⊉�h�x���`""BaB�v�a�X.��c�,	�v�okc���tD)a]&������������#�Q�鬈����n�����;�ICZZ1IĿ������gx�#�@�����*�U�zd�ߚ����t�t�X:C�gx���XѴtR�6���`�1^N��H�j3���QB��p����B�C�i���u������j<#��V�.+��`C@������b�I`�h{(���2�#m�[�B����η������!e>\/M��jc�F�.�u7�={ :;��4_]������^��B{��1]3�V��c�ڦ��1Ykw���L�]|����a%����t	nk�q该���}i�f��=(;'��Mi�j���v�M�[�o�Pn8�pL�q߽��Y����࿨���ZNS��[�9�> ���v���O�^ R=	8M�{�nnn*z�Ȇ E��}��´���E�9VvO8u���C+��s
iI։��1�����A�C4o��`�sr�zKd���sUj���}�H�	=҃3�"Y�C�N��p2��dګ�l������&�v<}�Wl0J�-�u�fFJ�0�c[��Ik&zAO��"q@O�Y\>f9!a�Rv�p��!��?��d6b2����q�IiVpA�юi��w��X�|�{��a�?�bF7M��ǜ�J1����S�(�+>Ev�Uː�̀�/�NJ��;S4�K�ߟ�XD�����A6�Hz?ܔ�ځ(����yD��ãj�)}d�a�*����CօKT��auV���;�'���SV�    IEND�B`�       ECFG      _global_script_classes             _global_script_class_icons             application/config/name      	   WitchSoul      application/run/main_scene$         res://Scenes/MainMenu.tscn     application/config/icon(         res://Assets/ui/witchavatar.png    display/window/size/width      8     display/window/size/height      �     display/window/stretch/mode         2d     display/window/stretch/aspect         keep   input/ui_accept�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device            alt           shift             control           meta          command           pressed           scancode        unicode           echo          script            InputEventKey         resource_local_to_scene           resource_name             device            alt           shift             control           meta          command           pressed           scancode        unicode           echo          script            InputEventKey         resource_local_to_scene           resource_name             device            alt           shift             control           meta          command           pressed           scancode          unicode           echo          script            InputEventJoypadButton        resource_local_to_scene           resource_name             device            button_index          pressure          pressed           script            InputEventKey         resource_local_to_scene           resource_name             device            alt           shift             control           meta          command           pressed           scancode   E      unicode           echo          script         input/ui_leftP              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device            alt           shift             control           meta          command           pressed           scancode        unicode           echo          script            InputEventJoypadButton        resource_local_to_scene           resource_name             device            button_index         pressure          pressed           script            InputEventKey         resource_local_to_scene           resource_name             device            alt           shift             control           meta          command           pressed           scancode   A      unicode           echo          script         input/ui_rightP              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device            alt           shift             control           meta          command           pressed           scancode        unicode           echo          script            InputEventJoypadButton        resource_local_to_scene           resource_name             device            button_index         pressure          pressed           script            InputEventKey         resource_local_to_scene           resource_name             device            alt           shift             control           meta          command           pressed           scancode   D      unicode           echo          script         input/ui_upP              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device            alt           shift             control           meta          command           pressed           scancode        unicode           echo          script            InputEventJoypadButton        resource_local_to_scene           resource_name             device            button_index         pressure          pressed           script            InputEventKey         resource_local_to_scene           resource_name             device            alt           shift             control           meta          command           pressed           scancode   W      unicode           echo          script         input/ui_downP              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device            alt           shift             control           meta          command           pressed           scancode        unicode           echo          script            InputEventJoypadButton        resource_local_to_scene           resource_name             device            button_index         pressure          pressed           script            InputEventKey         resource_local_to_scene           resource_name             device            alt           shift             control           meta          command           pressed           scancode   S      unicode           echo          script         input/right`              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device            alt           shift             control           meta          command           pressed           scancode   D      unicode           echo          script      
   input/left`              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device            alt           shift             control           meta          command           pressed           scancode   A      unicode           echo          script         input/up`              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device            alt           shift             control           meta          command           pressed           scancode   W      unicode           echo          script      
   input/down`              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device            alt           shift             control           meta          command           pressed           scancode   S      unicode           echo          script         input/e`              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device            alt           shift             control           meta          command           pressed           scancode   E      unicode           echo          script      	   input/esc`              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device            alt           shift             control           meta          command           pressed           scancode        unicode           echo          script         input/q`              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device            alt           shift             control           meta          command           pressed           scancode   Q      unicode           echo          script         input/UI`              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device            alt           shift             control           meta          command           pressed           scancode   Q      unicode           echo          script         layer_names/2d_physics/layer_1         player     layer_names/2d_physics/layer_2         npc    layer_names/2d_physics/layer_3         soul   layer_names/2d_physics/layer_4         object     layer_names/2d_physics/layer_5         door)   rendering/environment/default_clear_color        �?��+?��?  �?)   rendering/environment/default_environment          res://default_env.tres               