// This File contains the mapping of the choices to its respective module names in the database
// as well as a list of responses that trigger follow up questions that are used to check if the
// program should route to the follow up question based on the choice
class VerifyNextReference {
  final generalModule = {
    "Physical Health": "respond-physical-menu",
    "Mental Health": "mental_health_module",
    "Daily Living": "daily_living_scale_module",
    "Medical History": "respond-mental-menu",
    
    // M E D I C A L HISTORY MODULE 
    "Family History": "family_history_module",
    "Vaccination Record": "immunization_module", 

    // P H Y S I C A L HEALTH MODULE
    "Allergies": "allergy_module",
    ["Cough, Colds, Fever", "Ubo, Sipon Hilanat", "Ubo, Sipon, Lagnat"]: "cough_and_cold_module", 
    ["Skin", "Balat", "Panit"]: "skin_module",
    ["Head", "Ulo "]: "head_module",
    ["Ears", "Tenga", "Dalunggan"]: "ear_module",
    ["Eyes", "Mata"]: "eyes_module",
    ["Nose", "Ilong"]: "nose_module", 
    ["Heart and Lungs", "Puso at Baga", "Puso og Baga"]: "heart_lungs_module",
    ["Mouth and Teeth", "Bibig at Ngipin", "Baba ug Ngipon"]: "mouth_throat_teeth_module",
    ["Stomach", "Tiyan"]: "gi_module",
    ["Urination", "Pag-ihi"]: "gu_module",
    ["Bones and Muscle", "Buto at Muscle", "Buto ug Muscle"]: "buto_and_muscle_module",
    ["Circumcision / Mens", "Pag-tuli/Pag-regla"]: "endocrine_module"
  };

  final checkTriggerFollowUp = ["0 time",
                                "0 beses",
                                "Root canal treatment",
                                "Nagtambal sa root canal",
                                "Nagpagamot ng root canal",
                                "Oftentimes",
                                "Kasagaran",
                                "Madalas",
                                "Sa sulod na parte",
                                "Inner part",
                                "Sa bandang loob",
                                ];
}