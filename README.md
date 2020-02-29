# Comprobación algoritmo de detección de espectro basado en el procesamiento de las magnitudes instantáneas.

Códigos en MATLAB para comprobar el algoritmo de detección de espectro basado en el procesamiento de las magnitudes instantáneas.

Empleado para la comprobación de tecnica de sensado de espectro propuesta en artículo:
									 																															
																														
	IN ENGLISH
https://www.researchgate.net/publication/339375075_Spectrum_sensing_based_in_the_statistical_processing_of_instantaneous_magnitudes 

	DtS_V1 %Directorio básico.
	DtS_V1\Sx %Contiene las funciones de generación de señales
	DtS_V1\GRAFICOS %Contiene las funciones para graficar.
	DtS_V1\bASx %Contiene la función para obtener los vectores I y Q de la señal generada
	DtS_V1\bOPI %Contiene las funciones para obtener las magnitudes instantáneas
	DtS_V1\bDIEP %Contiene los módulos que componen el bloque de detección, identificación y estimación de parámetros
	DtS_V1\bDIEP\mPEVD %Módulo de procesamiento estadístico con ventana deslizante. Contiene las funciones para el cálculo de estadísticos de las magnitudes instantáneas
	DtS_V1\bDIEP\mDtS % Módulo de detección. Contiene la función que realiza la detección de espectro a partir de los estadísticos calculados en el mPEVD   

	DtS_V1\TestMDtS_VRepresDetecFHSS.m
	%SCRIPT para implementación del módulo de detección basado en el procesamiento estadístico de las magnitudes instantáneas. Se grafica la señal generada, el umbral de detección y se compara con la detección ideal.

	DtS_V1\TestMDtS_VDetermErrores.m
	%SCRIPT para graficar los errores en el proceso de detección. Se representan los errores para las distintas hipótesis en función de SNR.

	Las señales que se pueden generar son:
                                       
    GENERADOR DE SEÑALES DE PRUEBA
	% 1 % Señal de FHSS;
	% 2 % Señal LFM con control del ancho de banda 
	% 3 % Señal DSSS
	% 4 % Señal Pulso CW
	% 5 % Señal BPSK
	% 6 % Señal CW Coseno
	% 7 % Señal CW Seno
	% 8 % Señal DSSS Pulso
	% 9 % Señal de FHSS continua; 
	% otherwise %Señal VCO Frecuencia variable


Para seleccionar una señal se asigna a la variable (TipSx) el número de la señal que se desea generar

	
	Código distribuido bajo licencia ECR (Emplee, Contribuya y Reconozca)
	Code distributed under ECR license (Employ, Contribute and Recognize)
	Copyright (c) 2020 Jorge Y. Hernández García

https://www.researchgate.net/profile/Jorge_Y_Garcia

                                                
                                                ENGLISH
MATLAB codes to check the spectrum detection algorithm based on the processing of instantaneous magnitude.

Used for checking spectrum sensing technique proposed in article:
IN ENGLISH:
https://www.researchgate.net/publication/338901999_Determination_of_instantaneous_features_of_signals_for_real-time_applications_in_cognitive_radio 

	DtS_V1 %Basic directory.
	DtS_V1\Sx %Contains signal generation functions
	DtS_V1\GRAFICOS %Contains the functions to graph.
	DtS_V1\bASx %Contains the function to obtain vectors I and Q of the generated signal
	DtS_V1\bOPI %It contains the functions to obtain the instantaneous magnitudes
	DtS_V1\bDIEP %It contains modules that make up the block detection, identification and parameter estimation
	DtS_V1\bDIEP\mPEVD % Statistical processing module with sliding window. Contains the functions for calculating statistics of instantaneous magnitudes
	DtS_V1\bDIEP\mDtS % Detection module. It contains the function that performs the spectrum detection from the statistics calculated in the mPEVD   

	DtS_V1\TestMDtS_VRepresDetecFHSS.m
	%SCRIPT to implement the detection module based on the statistical processing of the instantaneous magnitudes. The generated signal, the detection threshold is plotted and compared to the ideal detection.

	DtS_V1\TestMDtS_VDetermErrores.m
	%SCRIPT to graph errors in the detection process. The errors are represented for the different hypotheses based on SNR.

	The signals that can be generated are:
                                          
			TEST SIGNAL GENERATOR
	% 1 % Señal de FHSS; 
	% 2 % Señal LFM con control del ancho de banda 
	% 3 % Señal DSSS
	% 4 % Señal Pulso CW
	% 5 % Señal BPSK
	% 6 % Señal CW Coseno
	% 7 % Señal CW Seno
	% 8 % Señal DSSS Pulso
	% 9 % Señal de FHSS continua; 
	% otherwise %Señal VCO Frecuencia variable


To select a signal, the number of the signal to be generated is assigned to the variable (TipSx)

	Código distribuido bajo licencia ECR (Emplee, Contribuya y Reconozca)
	Code distributed under ECR license (Employ, Contribute and Recognize)
	Copyright (c) 2020 Jorge Y. Hernández García

https://www.researchgate.net/profile/Jorge_Y_Garcia
