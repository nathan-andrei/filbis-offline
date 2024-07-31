// This File contains the mapping of the choices to its respective module names in the database
// as well as a list of responses that trigger follow up questions that are used to check if the
// program should route to the follow up question based on the choice

class VerifyNextReference {
  final generalModule = {
    
    "physical health": "respond-physical-menu",
    "mental health": "mental_health_module",
    "daily living": "daily_living_scale_module",
    "medical history": "respond-mental-menu",
    
    // M E D I C A L HISTORY MODULE 
    "family history": "family_history_module",
    "vaccination record": "immunization_module", 

    //---------- P H Y S I C A L HEALTH MODULE ---------- //
    "allergies": "allergy_module",

    "cough, colds, fever": "cough_and_cold_module", 
    "ubo, sipon hilanat": "cough_and_cold_module",
    "ubo, sipon, lagnat": "cough_and_cold_module",

    "skin": "skin_module",
    "balat": "skin_module",
    "panit": "skin_module",

    "head": "head_module",
    "ulo ": "head_module",

    "ears": "ear_module",
    "tenga": "ear_module",
    "dalunggan": "ear_module",

    "eyes": "eyes_module",
    "mata": "eyes_module",

    "nose": "nose_module", 

    "heart and lungs": "heart_lungs_module",
    "puso at baga": "heart_lungs_module",
    "puso og baga": "heart_lungs_module",

    "mouth and teeth": "mouth_throat_teeth_module",
    "bibig at ngipin": "mouth_throat_teeth_module",
    "baba ug ngipon": "mouth_throat_teeth_module",

    "stomach": "gi_module",
    "tiyan": "gi_module",

    "urination": "gu_module",
    "pag-ihi": "gu_module",

    "bones and muscle": "buto_and_muscle_module",
    "buto at muscle": "buto_and_muscle_module",
    "buto ug muscle": "buto_and_muscle_module",
    
    "circumcision / mens": "endocrine_module",
    "pag-tuli / pag-regla": "endocrine_module"
  };

  final checkTriggerFollowUp = ["0 time",
                  "0 beses",
                  "root canal treatment",
                  "nagtambal sa root canal",
                  "nagpagamot ng root canal",
                  "oftentimes",
                  "kasagaran",
                  "madalas",
                  "sa sulod na parte",
                  "inner part",
                  "sa bandang loob",
                  "yes", 
                  "oo",
                  "meron",
                  "brownish", 
                  "bloody", 
                  "murag chocolate", 
                  "puwa murag dugo",
                  "mala-tsokolate",
                  "mapula parang dugo",
                  "prescription",
                  "oo, aduna",
                  "oo, meron",
                  "yes, there is",
                  "itom",
                  "blackish",
                  "maitim",
                  "from food",
                  "dahil sa kinain",
                  "tungod sa akong nakaon",
                  "yes, i will try",
                  "sige, susubukan ko",
                  // "yellow", unsure to include because it might affect other questions
                  // "dilaw"
                  ];
}