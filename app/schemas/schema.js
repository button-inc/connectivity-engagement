const schema = {
  "title": "Connectivity Grant Application Form",
  "description": "Enter required information to apply for connectivity grant.",
  "type": "object",
  "properties": {
    "name": {
      "type": "string"
    },
    "address": {
      "type": "string"
    },
    "reason": {
      "type": "string"
    },
    "confirmation": {
      "type": "boolean",
      "title": "Is all info correct?"
    },
  }
};

export default schema;
