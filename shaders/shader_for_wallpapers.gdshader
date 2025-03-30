shader_type canvas_item;

// Параметры для настройки фона
uniform float darkness : hint_range(0.0, 1.0) = 1.0;      // Сила затемнения (0.0 - чёрный, 1.0 - без изменений)
uniform float desaturation : hint_range(0.0, 1.0) = 0.0;  // Обесцвечивание (0.0 - цветной, 1.0 - чёрно-белый)
uniform float brightness : hint_range(0.0, 2.0) = 1.0;    // Яркость (0.0 - тёмный, 1.0 - исходный, 2.0 - яркий)
uniform float contrast : hint_range(0.0, 2.0) = 1.0;      // Контраст (0.0 - серый, 1.0 - исходный, 2.0 - высокий контраст)
uniform float tint_strength : hint_range(0.0, 1.0) = 0.0; // Сила оттенка (0.0 - без оттенка, 1.0 - полный оттенок)
uniform float alpha : hint_range(0.0, 1.0) = 1.0;         // Прозрачность (0.0 - невидимый, 1.0 - непрозрачный)

void fragment() {
    // Берём исходный цвет фона
    vec4 color = texture(TEXTURE, UV);
    
    // Применяем затемнение
    color.rgb *= darkness;
    
    // Применяем обесцвечивание
    float gray = dot(color.rgb, vec3(0.299, 0.587, 0.114)); // Преобразуем в серый
    color.rgb = mix(color.rgb, vec3(gray), desaturation);
    
    // Применяем яркость
    color.rgb *= brightness;
    
    // Применяем контраст
    color.rgb = (color.rgb - 0.5) * contrast + 0.5;
    
    
    // Устанавливаем итоговый цвет и прозрачность
    COLOR = color;
    COLOR.a = alpha;
}