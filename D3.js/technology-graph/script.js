console.log("Script enlazado")

d3.csv("stack_network_nodes.csv").then(function(dataNodes) {    // Carga del fichero que contiene los nodos
    console.log("Se han cargado los nodos")
    
    d3.csv("stack_network_links.csv").then(function(dataLinks) {        // Carga del fichero que contiene los arcos
        console.log("Se han cargado los arcos")
        
        //window.data = dataLinks;

        var escalaColor = d3.scaleOrdinal(["#a6cee3", "#1f78b4", "#b2df8a", "#33a02c", "#fb9a99", "#e31a1c", "#fdbf6f", 
                                           "#ff7f00", "#cab2d6", "#6a3d9a", "#ff1493", "#b15928", "#0000ff", "#00ffff"])
        
        var escalaNodes = d3.scaleLinear()
            .domain(d3.extent(dataNodes, d => parseFloat(d.nodesize)))
            .range([4,12])
        
        var escalaLink = d3.scaleLinear()
            .domain(d3.extent(dataLinks, d => parseFloat(d.value)))
            .range([0.5,5])
        
        var layout = d3.forceSimulation()                       // Layout de fuerzas
            .force("link", d3.forceLink().id(d => d.name))      // Atracción de nodos
            .force("charge", d3.forceManyBody())                // Repele los nodos
            .force("center", d3.forceCenter(750,650))           // "Centra" el grafo

        layout
            .nodes(dataNodes)       // Aplica el layout a los datos de los nodos
            .on("tick", onTick)     // Evento que permite actualizar los nodos

        layout
            .force("link")          // Hace referencia a la fuerza link
            .links(dataLinks)       // Aplica la fuerza a los datos de los arcos

        var svg = d3.select("body") // Crea el svg
            .append("svg")
            .attr("height", 1500)
            .attr("width", 1500)

        var links = svg             // Asigna un elemento línea por cada registro
            .append("g")
            .attr("class", "links")
            .selectAll("line")
            .data(dataLinks)
            .enter()
            .append("line")
            .style("stroke", "#ddd")

        var nodes = svg             // Asigna un elemento círculo por cada registro
            .append("g")
            .attr("class", "nodes")
            .selectAll("circles")
            .data(dataNodes)
            .enter()
            .append("circle")
            .attr("r", d => escalaNodes(d.nodesize))    // Se aplica la escala a los nodos
            .attr("fill", d => escalaColor(d.group))    // Se aplica escala de color a los nodos
            .on("mouseover", d => pintar(d))            // Evento que desencadena las acciones pintar
            .on("mouseout", borrar)                     // Evento que desencadena las acciones borrar
        
        var texto = svg
            .append("g")
            .attr("class", "texto")
            .selectAll("text")
            .data(dataNodes)
            .enter()
            .append("text")
            .attr("dx", 12)
            .attr("dy", ".35em")
        
        
        var dict_links = {};
        for(var i=0;i<dataLinks.length; i++) {                                                  // Diccionario con los nodos conectados
            dict_links[dataLinks[i].source.index + "," + dataLinks[i].target.index] = 1;
        }

        function isConnected(a, b) {                                                           // Verifica si los nodos están conectados
            return dict_links[a.index + "," + b.index] || dict_links[b.index + "," + a.index] || a.index == b.index;
        }

        function borrar() {                         // "Borra" las etiquetas, las líneas coloreadas, etc

            nodes
                .style("stroke-opacity", 1)
                .style("fill-opacity", 1);
            
            links
                .style("stroke-opacity", 1)
                .style("stroke", "#ddd");
            
            texto 
                .text("")
        }

        function pintar(d) {

            nodes.style("fill-opacity", o => {      // Mantiene la opacidad máxima a los nodos que están conectados
                if(isConnected(d, o))              // y los que no están conectados les baja la opacidad
                    return 1 
                else
                    return 0.2
            });

            links.style("stroke-opacity", o => {            // Mantiene la opacidad máxima a los arcos de los nodos que están conectados
                if(o.source === d || o.target === d)        // y baja la opacidad a los que no
                    return 1 
                else
                    0.2
            });

            links.style("stroke", o => {
                if(o.source === d || o.target === d)        // Colorea según la escala de color los arcos de los nodos conectados
                    return escalaColor(o.target.group)
                else
                    return "#ddd"
            });
            
            texto
                .text(o => {                        // Muestra el nombre de los nodos si éstos están conectados
                    if(isConnected(d, o))           // junto a los nodos según las coordenadas asginadas por el layout de fuerzas
                        return o.name               // Los textos están desplazados un incremento de x e y asignados en la variable nodes
                    else 
                        return ""
                })
                .attr("transform", function(d) {return "translate(" + d.x + "," + d.y + ")"})
            
        }

        function onTick() {
            nodes
                .attr("cx", d => d.x)   // En cada tick se van asignando a los nodos las nuevas coordenadas incrustadas por el layout de fuerzas
                .attr("cy", d => d.y)
            
            /*texto
                .attr("transform", function(d) {return "translate(" + d.x + "," + d.y + ")"})*/

            links
                .attr("x1", d => d.source.x)    // En cada tick se van asignando a los links las nuevas coordenadas de inicio y fin incrustadas por el layout de fuerzas
                .attr("x2", d => d.target.x)
                .attr("y1", d => d.source.y)
                .attr("y2", d => d.target.y)
                .attr("stroke-width", d=> escalaLink(d.value))  // Establece un ancho de cada link según el valor obtenido al aplicar la escala
        }
        
    });
    
})