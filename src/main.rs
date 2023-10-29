use openscad_customizer_rs::{ParameterSets, ParameterSet};
use serde_json::json;

use std::fs::File;
use std::io::prelude::*;

fn main() {
    println!("Hello, world!");
    let mut parameter_sets = ParameterSets::from_file_path("data/airfoil/airfoil.json".to_string());
    let camber = "3.0";

    match parameter_sets{
        Ok(mut parameters)=>{
            let mut airfoil_set = parameters.get_parameter_set("design default values".to_string());
            match airfoil_set{
                Ok(parameter_set)=>{
                    let mut params_kvs = parameter_set.get_key_values();
                    let mut new_params = params_kvs.clone();
                    new_params.insert("camber".to_string(), json!(camber));

                    parameters.set_parameter_set("parameterSets".to_string(), new_params);

                    let output = serde_json::to_string_pretty(&parameters).unwrap();
                    let mut file = File::create("data/airfoil/airfoil_new.json");
                    file.unwrap().write_all(output.as_bytes()).unwrap();
                }
                Err(_)=>{
                    println!("Couldn't change camber...");
                }
            }
        }
        Err(_)=>{
            println!("No Parameter sets...");
        }
    }


}
