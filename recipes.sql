--
-- PostgreSQL database dump
--

-- Dumped from database version 13.10 (Ubuntu 13.10-1.pgdg22.04+1)
-- Dumped by pg_dump version 13.10 (Ubuntu 13.10-1.pgdg22.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE ONLY public.shopping_lists DROP CONSTRAINT shopping_lists_user_id_fkey;
ALTER TABLE ONLY public.ratings DROP CONSTRAINT ratings_user_id_fkey;
ALTER TABLE ONLY public.ratings DROP CONSTRAINT ratings_recipe_id_fkey;
ALTER TABLE ONLY public.ingredients DROP CONSTRAINT ingredients_shopping_list_id_fkey;
ALTER TABLE ONLY public.fav_recipes DROP CONSTRAINT fav_recipes_user_id_fkey;
ALTER TABLE ONLY public.fav_recipes DROP CONSTRAINT fav_recipes_recipe_id_fkey;
ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key;
ALTER TABLE ONLY public.shopping_lists DROP CONSTRAINT shopping_lists_pkey;
ALTER TABLE ONLY public.recipes DROP CONSTRAINT recipes_pkey;
ALTER TABLE ONLY public.ratings DROP CONSTRAINT ratings_pkey;
ALTER TABLE ONLY public.ingredients DROP CONSTRAINT ingredients_pkey;
ALTER TABLE ONLY public.fav_recipes DROP CONSTRAINT fav_recipes_pkey;
ALTER TABLE public.users ALTER COLUMN user_id DROP DEFAULT;
ALTER TABLE public.shopping_lists ALTER COLUMN shopping_list_id DROP DEFAULT;
ALTER TABLE public.recipes ALTER COLUMN recipe_id DROP DEFAULT;
ALTER TABLE public.ratings ALTER COLUMN rating_id DROP DEFAULT;
ALTER TABLE public.ingredients ALTER COLUMN ingredient_id DROP DEFAULT;
ALTER TABLE public.fav_recipes ALTER COLUMN fav_recipe_id DROP DEFAULT;
DROP SEQUENCE public.users_user_id_seq;
DROP TABLE public.users;
DROP SEQUENCE public.shopping_lists_shopping_list_id_seq;
DROP TABLE public.shopping_lists;
DROP SEQUENCE public.recipes_recipe_id_seq;
DROP TABLE public.recipes;
DROP SEQUENCE public.ratings_rating_id_seq;
DROP TABLE public.ratings;
DROP SEQUENCE public.ingredients_ingredient_id_seq;
DROP TABLE public.ingredients;
DROP SEQUENCE public.fav_recipes_fav_recipe_id_seq;
DROP TABLE public.fav_recipes;
SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: fav_recipes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fav_recipes (
    fav_recipe_id integer NOT NULL,
    recipe_id integer,
    user_id integer
);


--
-- Name: fav_recipes_fav_recipe_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.fav_recipes_fav_recipe_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: fav_recipes_fav_recipe_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.fav_recipes_fav_recipe_id_seq OWNED BY public.fav_recipes.fav_recipe_id;


--
-- Name: ingredients; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ingredients (
    ingredient_id integer NOT NULL,
    name character varying(200),
    complete boolean,
    shopping_list_id integer
);


--
-- Name: ingredients_ingredient_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.ingredients_ingredient_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ingredients_ingredient_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.ingredients_ingredient_id_seq OWNED BY public.ingredients.ingredient_id;


--
-- Name: ratings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ratings (
    rating_id integer NOT NULL,
    score integer,
    comment text,
    count integer,
    recipe_id integer,
    user_id integer
);


--
-- Name: ratings_rating_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.ratings_rating_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ratings_rating_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.ratings_rating_id_seq OWNED BY public.ratings.rating_id;


--
-- Name: recipes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.recipes (
    recipe_id integer NOT NULL,
    image character varying,
    image_type character varying(10),
    likes integer,
    missed_ingredient_count integer,
    missed_ingredients character varying[],
    title character varying,
    instructions character varying[],
    ingredients character varying[],
    ready_minutes integer
);


--
-- Name: recipes_recipe_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.recipes_recipe_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: recipes_recipe_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.recipes_recipe_id_seq OWNED BY public.recipes.recipe_id;


--
-- Name: shopping_lists; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.shopping_lists (
    shopping_list_id integer NOT NULL,
    user_id integer
);


--
-- Name: shopping_lists_shopping_list_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.shopping_lists_shopping_list_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: shopping_lists_shopping_list_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.shopping_lists_shopping_list_id_seq OWNED BY public.shopping_lists.shopping_list_id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    email character varying,
    password character varying
);


--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: fav_recipes fav_recipe_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fav_recipes ALTER COLUMN fav_recipe_id SET DEFAULT nextval('public.fav_recipes_fav_recipe_id_seq'::regclass);


--
-- Name: ingredients ingredient_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ingredients ALTER COLUMN ingredient_id SET DEFAULT nextval('public.ingredients_ingredient_id_seq'::regclass);


--
-- Name: ratings rating_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ratings ALTER COLUMN rating_id SET DEFAULT nextval('public.ratings_rating_id_seq'::regclass);


--
-- Name: recipes recipe_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recipes ALTER COLUMN recipe_id SET DEFAULT nextval('public.recipes_recipe_id_seq'::regclass);


--
-- Name: shopping_lists shopping_list_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shopping_lists ALTER COLUMN shopping_list_id SET DEFAULT nextval('public.shopping_lists_shopping_list_id_seq'::regclass);


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Data for Name: fav_recipes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.fav_recipes (fav_recipe_id, recipe_id, user_id) FROM stdin;
1	652952	1
2	715381	1
3	664089	1
4	639637	1
5	1155776	1
6	635778	1
7	632253	1
8	653149	1
9	649684	1
10	1096274	1
19	649684	2
21	652952	3
22	715381	3
23	664089	3
24	639637	3
25	1155776	3
26	635778	3
27	632253	3
28	653149	3
29	649684	3
30	1096274	3
31	652952	4
32	715381	4
33	664089	4
34	639637	4
35	1155776	4
36	635778	4
37	632253	4
38	653149	4
39	649684	4
40	1096274	4
41	652952	5
42	715381	5
43	664089	5
44	639637	5
45	1155776	5
46	635778	5
47	632253	5
48	653149	5
49	649684	5
50	1096274	5
51	652952	6
52	715381	6
53	664089	6
54	639637	6
55	1155776	6
56	635778	6
57	632253	6
58	653149	6
59	649684	6
60	1096274	6
61	652952	7
62	715381	7
63	664089	7
64	639637	7
65	1155776	7
66	635778	7
67	632253	7
68	653149	7
69	649684	7
70	1096274	7
71	652952	8
72	715381	8
73	664089	8
74	639637	8
75	1155776	8
76	635778	8
77	632253	8
78	653149	8
79	649684	8
80	1096274	8
81	652952	9
82	715381	9
83	664089	9
84	639637	9
85	1155776	9
86	635778	9
87	632253	9
88	653149	9
89	649684	9
90	1096274	9
91	652952	10
92	715381	10
93	664089	10
94	639637	10
95	1155776	10
96	635778	10
97	632253	10
98	653149	10
99	649684	10
100	1096274	10
104	661522	2
107	639637	2
108	664089	2
109	635778	2
119	652952	2
123	632253	2
124	1155776	2
125	715381	2
126	641890	2
127	636458	2
\.


--
-- Data for Name: ingredients; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.ingredients (ingredient_id, name, complete, shopping_list_id) FROM stdin;
63	self raising flour: 2.0 cups	f	2
64	cayenne pepper	f	2
65	regular chicken wings	f	2
66	whipping cream: 2.0 cups	f	2
67	Lime essential oil (this is the brand I use) OR if not using essential oils, use 1 Tbsp grated lime zest: 2.0 drop	f	2
68	butternut squash	f	2
69	bacon: 12.0 slices	f	2
70	fresh blueberries: 12.0 	f	2
71	milk	f	2
72	all purpose flour: 0.6666667 cup	f	2
73	eggs	f	2
74	baking powder	f	2
75	ground nutmeg: 0.125 teaspoon	f	2
76	graham cracker crumbs	f	2
77	lime zest	f	2
78	rum or orange extract: 3.0 teaspoons	f	2
79	milk: 0.75 cup	f	2
\.


--
-- Data for Name: ratings; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.ratings (rating_id, score, comment, count, recipe_id, user_id) FROM stdin;
1	5	Awesome Recipe!	1	652952	1
3	3	Didn't look like the picture	3	652952	3
4	5	Tasted Amazing!	4	652952	4
5	3	Loved it!!!	5	652952	5
6	4	Hated it!!!	6	652952	6
7	5	Cant wait to make again	7	652952	7
8	2	It was mid	8	652952	8
9	3	best recipe eveeer	9	652952	9
10	1	Just alright	10	652952	10
11	5	Awesome Recipe!	11	715381	1
13	3	Didn't look like the picture	13	715381	3
14	5	Tasted Amazing!	14	715381	4
15	3	Loved it!!!	15	715381	5
16	4	Hated it!!!	16	715381	6
17	5	Cant wait to make again	17	715381	7
18	2	It was mid	18	715381	8
19	3	best recipe eveeer	19	715381	9
20	1	Just alright	20	715381	10
21	5	Awesome Recipe!	21	664089	1
23	3	Didn't look like the picture	23	664089	3
24	5	Tasted Amazing!	24	664089	4
25	3	Loved it!!!	25	664089	5
26	4	Hated it!!!	26	664089	6
27	5	Cant wait to make again	27	664089	7
28	2	It was mid	28	664089	8
29	3	best recipe eveeer	29	664089	9
30	1	Just alright	30	664089	10
31	5	Awesome Recipe!	31	639637	1
33	3	Didn't look like the picture	33	639637	3
34	5	Tasted Amazing!	34	639637	4
35	3	Loved it!!!	35	639637	5
36	4	Hated it!!!	36	639637	6
37	5	Cant wait to make again	37	639637	7
38	2	It was mid	38	639637	8
39	3	best recipe eveeer	39	639637	9
40	1	Just alright	40	639637	10
41	5	Awesome Recipe!	41	1155776	1
43	3	Didn't look like the picture	43	1155776	3
44	5	Tasted Amazing!	44	1155776	4
45	3	Loved it!!!	45	1155776	5
46	4	Hated it!!!	46	1155776	6
47	5	Cant wait to make again	47	1155776	7
48	2	It was mid	48	1155776	8
49	3	best recipe eveeer	49	1155776	9
50	1	Just alright	50	1155776	10
51	5	Awesome Recipe!	51	635778	1
52	1	Tasted Bad	52	635778	2
53	3	Didn't look like the picture	53	635778	3
54	5	Tasted Amazing!	54	635778	4
55	3	Loved it!!!	55	635778	5
56	4	Hated it!!!	56	635778	6
57	5	Cant wait to make again	57	635778	7
58	2	It was mid	58	635778	8
59	3	best recipe eveeer	59	635778	9
60	1	Just alright	60	635778	10
61	5	Awesome Recipe!	61	632253	1
63	3	Didn't look like the picture	63	632253	3
64	5	Tasted Amazing!	64	632253	4
65	3	Loved it!!!	65	632253	5
66	4	Hated it!!!	66	632253	6
67	5	Cant wait to make again	67	632253	7
68	2	It was mid	68	632253	8
69	3	best recipe eveeer	69	632253	9
70	1	Just alright	70	632253	10
71	5	Awesome Recipe!	71	653149	1
72	1	Tasted Bad	72	653149	2
73	3	Didn't look like the picture	73	653149	3
74	5	Tasted Amazing!	74	653149	4
75	3	Loved it!!!	75	653149	5
76	4	Hated it!!!	76	653149	6
77	5	Cant wait to make again	77	653149	7
78	2	It was mid	78	653149	8
79	3	best recipe eveeer	79	653149	9
80	1	Just alright	80	653149	10
81	5	Awesome Recipe!	81	649684	1
82	1	Tasted Bad	82	649684	2
83	3	Didn't look like the picture	83	649684	3
84	5	Tasted Amazing!	84	649684	4
85	3	Loved it!!!	85	649684	5
86	4	Hated it!!!	86	649684	6
87	5	Cant wait to make again	87	649684	7
88	2	It was mid	88	649684	8
89	3	best recipe eveeer	89	649684	9
90	1	Just alright	90	649684	10
91	5	Awesome Recipe!	91	1096274	1
92	1	Tasted Bad	92	1096274	2
93	3	Didn't look like the picture	93	1096274	3
94	5	Tasted Amazing!	94	1096274	4
95	3	Loved it!!!	95	1096274	5
96	4	Hated it!!!	96	1096274	6
97	5	Cant wait to make again	97	1096274	7
98	2	It was mid	98	1096274	8
99	3	best recipe eveeer	99	1096274	9
100	1	Just alright	100	1096274	10
12	5	Great!\r\n	12	715381	2
101	5	So delish and easy to make! :)	1	661522	2
22	3	great!	22	664089	2
2	1	Not my Favorite!	2	652952	2
32	1	Not my favorite recipe...	32	639637	2
62	5	Great!	62	632253	2
42	1	Just ok!	42	1155776	2
\.


--
-- Data for Name: recipes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.recipes (recipe_id, image, image_type, likes, missed_ingredient_count, missed_ingredients, title, instructions, ingredients, ready_minutes) FROM stdin;
653149	https://spoonacular.com/recipeImages/653149-312x231.jpg	jpg	0	3	{"package cranberries",orange,pecans}	No Cook Cranberry Orange Relish	{"Pick through the cranberries and remove any bad ones.","Cut the orange into eights and remove the seeds.","Place half the cranberries and half the orange in a food processor, fitted with the steel blade, and pulse until the mixture is evenly chopped, but not pureed.","Transfer to a medium bowl. Repeat with the remaining cranberries and orange.","Combine all ingredients in bowl and stir in the sugar.","Cover and refrigerate for at least 2 days or up to 2 weeks.","Serve chilled or at room temperature."}	{"1, package cranberries: 12.0 ounce","orange, unpeeled: 1.0 ","sugar: 1.0 cup","chopped pecans, optional: 0.5 cup"}	45
715381	https://spoonacular.com/recipeImages/715381-312x231.jpg	jpg	1	3	{"graham cracker crumbs","lime zest",butter}	Creamy Lime Pie Square Bites	{"Preheat oven to 35","Cover an 88 glass square dish with foil.","Whisk together all of your crust ingredients until it becomes a grainy consistency. Take a spoon and press the graham crust into the foil making sure all of the edges and bottom are completely covered.","Place into the oven and bake for 10-15 minutes until browned.","Remove from oven and allow to cool for about an hour.For the filling, add all of your ingredients into a medium bowl and mix well for about 30 minutes, and then for 3 minutes on low.","Place into the graham cracker crust, making sure all of the edges are filled.","Bake in the oven for about 5-10 minutes, and then remove.","Place onto a cooling rack for about 15 minutes, and then chill in the refrigerator for remaining 45 minutes to set.To serve, remove carefully from dish with foil and cut into bite sized squares.Looking for other ways to use Lime Essential Oil? A great group of bloggers and myself got together so we could share our favorite recipes to use with Lime. You dont have to use essential oils in order to make this delicious dessert, but if you have on hand, give it a try! You can find all of the other great Lime recipes below. Leave me a comment if you make these Creamy Lime Pie Square Bites and tell me if you love them as much as we do!If you have ever wanted to start using essential oils, you can read all about WHY I love to use mine here. Want to use Lime in a few different recipes? Check these additional recipes out.Coconut Lime Spritzer // Blackberry Lime Margaritas // Strawberry Limeade","Cherry Lime Chia Energy Bars // Strawberry Margarita Cheesecake // Creamy Lime Pie Bites","Margarita Crepe Cake //Edible Watermelon Bowl // Margarita Cookies","Southwestern Black Bean & Corn Salad // Lime Cheesecake Shooters","Not all essential oils are edible. Due to lack of purity, 98% of essential oils sold should NOT be ingested. An edible essential oil will be labeled therapeutic-grade and have a Supplement Facts box on the label showing the nutritional value  do NOT use just any brand of essential oil for cooking/flavoring foods. Be sure to use pure oils from reliable sources, not synthetic scents or flavorings.JOIN 500,000 SUBSCRIBERS!Join over 500,000 others who follow Pink","When on Social Media, the Pink","When blog, and email. Sign up to receive exclusive bonuses like this FREE Simple Fit Dinners Ebook.Don't wait! You won't want to miss a thing.Success! Now check your email to confirm your subscription and download your FREE ebook.There was an error submitting your subscription. Please try again.First Name",Email,Address,Subscribe,"Powered by Convert",Kit}	{"all purpose flour: 0.6666667 cup","crushed graham cracker crumbs: 1.0 cup","Lime essential oil (this is the brand I use) OR if not using essential oils, use 1 Tbsp grated lime zest: 2.0 drop","sugar: 2.0 tbsp","unsalted butter (softened): 5.0 Tbsp"}	45
632253	https://spoonacular.com/recipeImages/632253-312x231.jpg	jpg	0	3	{"ground nutmeg","orange extract",pecans}	Alouette® Cranberry Brie	{"Preheat oven to 450 F.","Remove top rind of Alouette Baby Brie leaving a 3\\" rim around the circumference of the cheese.In a small bowl combine Cran-Fruit, brown sugar, extract and nutmeg.Top Alouette Baby Brie with cranberry mixture and sprinkle with 2 tbsp. chopped pecans.","Place in an ovenproof dish and bake in a 450 F oven for 4-5 minutes.","Serve warm with assorted crackers or apple slices."}	{"packed dark brown sugar: 2.0 tablespoons","ground nutmeg: 0.125 teaspoon","rum or orange extract: 3.0 teaspoons","chopped pecans: 2.0 tablespoons"}	45
1155776	https://spoonacular.com/recipeImages/1155776-312x231.jpg	jpg	0	3	{vanilla,"cream cheese","semi chocolate chips"}	Easy Homemade Chocolate Truffles	{"First you will want to place your cream cheese into a medium sized bowl and beat until smooth.","Once the cream cheese is smooth, gradually add in the powdered sugar a little at a time and continue to beat until smooth.","Add in the vanilla and chocolate and beat until you have once again reached a smooth consistency.","Cover and place in the refrigerator for 1 hour.","After one hour, use a 2 inch cookie scoop and create perfectly round truffles.","Delicious Chocolate Truffle Recipe","To decorate, use melting chocolate candies in different colors and dip with a fork, then place on waxed paper to completely harden. Then dip truffles in a second coat of chocolate and coat with sprinkles or other toppings while still tacky. Allow to completely harden before serving."}	{"vanilla: 1.5 tsp","package cream cheese: 8.0 oz","powdered sugar: 3.0 cups","semi sweet chocolate chips melted: 3.0 cups"}	35
649684	https://spoonacular.com/recipeImages/649684-312x231.jpg	jpg	0	3	{"cream of tartar","egg whites","juice of lemon"}	Lemon Meringue Cookies	{"By Lori Longbotham, \\"Cookies - Food Writers' Favorites\\"With electric mixer, beat whites until foamy.","Add cream of tartar, and beat on high speed until soft peaks form. Beat in sugar, 1 tablespoon at a time; continue beating until stiff and shiny peaks form. Gently fold in lemon zest. Drop mixture by heaping tablespoons onto 2 buttered and floured baking sheets.","Bake in preheated 250 degree oven 1 hour. Turn off oven; do not open oven door. Leave cookies undisturbed, in oven for 1 hour. Then transfer to wire racks to cool completely. Store in a tightly covered container.Note: Recipe can be doubled or tripled if you save egg whites in the freezer, like I do; just defrost and bring to room temperature before using. Like most meringue recipes, you need a low humidity day and utensils that are free from any fat residue, to be successful. Any citrus zest will work fine to vary the flavor."}	{"cream of tartar: 0.25 teaspoon","egg whites: 2.0 ","Granulated sugar: 6.0 tablespoons","lemons, juiced and zested: 6.0 "}	45
665330	https://spoonacular.com/recipeImages/665330-312x231.jpg	jpg	0	2	{blackberries,lavender}	Wild Blackberry Sorbet With Garden Mint & Lavender	{"Lay the clean, drained berries in a single layer on a cookie sheet and place in the freezer until frozen through. It is best to do both this and the next step the day or night before you plan to make the sorbet - just make sure you leave enough time for everything to freeze.","Make the herb-infused simple syrup by combining the water and sugar in a small heavy-bottomed saucepan and heat over a medium flame until it comes to a boil. Turn it off and let cool completely.","Strain out the mint leaves and lavender and pour the cooled syrup into an ice cube tray - should make roughly 4 syrup cubes.","Place the tray in the freezer until syrup is frozen (the cubes may remain a little mushy as a result of all the sugar.)","Once the berries and herb-infused syrup cubes have frozen, you can make the sorbet.","Place the frozen berries and syrup cubes in the bowl of a cuisinart or blender and add a few teaspoons of ice water to aid in blending. Continue to process or blend, adding small amounts of the ice water as needed, until smooth.","Serve, topped with a sprig of mint leaves and/or lavender."}	{"fresh blackberries, washed and dried: 3.0 cups","organic sugar: 0.25 cup","water: 0.25 cup","fresh mint leaves, washed and dried: 1.0 handful","fresh lavender, washed and dried: 3.0 sprigs","Ice water for blending: 4.0 servings"}	45
651250	https://spoonacular.com/recipeImages/651250-312x231.jpg	jpg	0	3	{eggs,honey,"tea drink"}	Matcha Kasutera Honey Sponge Cake	{"Line a 44x12x6-cm wood box or an 9-inch baking pan with parchment paper. Fill half of a large pot with water and bring it to a boil. Stir together the honey and green tea drink in a small bowl.","Combine the flour, matcha tea powder and sift twice and set aside. Preheat the oven to 175C/350F.","Place the eggs and the sugar into the bowl of your mixer. Set the bowl over the pot of hot water and whisk the mixture until lukewarm and the sugar is dissolved.","Remove and beat over medium speed until the mixture starts to thicken. Lower the speed and continue whisking until it is thick and smooth. When you lift the whisk, the peaks drops slightly. Beat in honey water mixture in a few additions until incorporated.Sift in the flour in a few additions and whisk on low speed until fully incorporated.","Pour the batter into the prepared wood box or the pan.","Place in the hot oven and bake until the cake is golden brown and it feels spongy not tacky to the touch, about 50 minutes. Cool on the rack for 10 minutes, and remove from the pan."}	{"Eggs separated (total weight 270-280g), at room temperature: 5.0 ","German #550 flour: 125.0 grams","Honey: 50.0 grams","Matcha tea powder: 10.0 grams","Green tea drink: 50.0 grams"}	45
663176	https://spoonacular.com/recipeImages/663176-312x231.jpg	jpg	0	3	{"coconut milk",mangos,"freshly short-grain"}	Thai-Style Sticky Rice & Mango Dessert Shots	{"Heat the coconut milk in a medium saucepan over medium-low heat, stirring constantly to avoid curdling.Bring to a low simmer, then add the sugar and salt and whisk together until combined.","Remove from heat.","Pour about 3/4 of the sweetened coconut milk onto the warm rice.Allow to sit for about 10 minutes or until the rice has completely absorbed the coconut milk.In the meantime, carefully peel and chop the mango into 1/2\\" pieces.Assemble your dessert shots by putting about 1 tablespoon of sweetened sticky rice into each shot glass.","Layer a generous amount of mango chunks on top, then add more sticky rice.Top each shot with a small amount of the remaining coconut milk.","Garnish with a couple extra pieces of mango and a basil or mint leaf, and enjoy!"}	{"coconut milk: 14.0 oz","Fresh basil or mint leaves for garnish: 10.0 servings","fresh mangos: 2.0 ","salt: 0.5 teaspoon","freshly cooked short-grain, glutinous rice (Arborio, Thai sticky rice or: 1.0 cup","sugar: 2.0 tablespoons"}	45
665482	https://spoonacular.com/recipeImages/665482-312x231.jpg	jpg	0	5	{butter,walnuts,"quick-cooking oats",chocolate,vanilla}	Xocai No Bake Cookies	{"Combine sugar, butter and milk in a pan. Bring to a boil and boil for 1 minute.","Pour mixture over nuts, oats, X Power Squares and vanilla. Drop by teaspoonful on wax paper or foil. Cookies will harden as they cool. Makes 24 Cookies"}	{"sugar (substitute): 2.0 cups","butter (substitute): 0.5 cup","soy milk: 0.5 cup","chopped walnuts: 0.75 cup","quick-cooking oats: 3.0 cups","dark chocolate (Xocai X Power Squares, chopped): 1.0 cup","vanilla: 1.0 tsp"}	45
665484	https://spoonacular.com/recipeImages/665484-312x231.jpg	jpg	0	6	{"butter substitute","xocai healthy chocolate nugget",oats,"peanut butter","sugar substitute",vanilla}	Xocai Oatmeal Dark Chocolate No-Bake Cookies	{"Combine the first four ingredient in a medium sauce pan.","Heat mixture until it boils. Boils for 5 minutes, stirring constantly.","Remove from heat and stir in remaining ingredients.","Add the Nuggets last. Drop by spoonful onto wax paper or foil. Cookies will harden as they cool. Makes 24 cookies"}	{"butter substitute: 0.5 cup","Xocai Healthy Chocolate Nugget, chopped: 1.0 ","oats: 3.0 cups","peanut butter: 2.0 cup","soy milk: 0.5 cup","sugar substitute: 2.0 cups","vanilla: 1.0 tsp"}	45
649690	https://spoonacular.com/recipeImages/649690-312x231.jpg	jpg	0	3	{"lemon zest","lemon juice",limoncello}	Lemon Mint Sorbet	{"Pour the water, sugar and lemon zest into a pot over medium high heat until the sugar has completely dissolved, stirring occasionally.","Remove from heat, stir in the mint and set aside.","As the simple syrup steeps, whisk together the lemon juice, limoncello and salt.","Pour into the minted simple syrup and allow to cool completely. Chill for at least 3 hours, but preferably overnight.","Once the liquid has chilled, pour it into the frozen base of your ice cream maker, cover with the lid and churn for 20-30 minutes or until the mixture thickens.","Put the base into the freezer for another hour or two to harden as desired."}	{"water: 3.0 cups","sugar: 2.0 cups","Zest of large lemons: 3.0 large","fresh mint leaves, finely minced and divided: 1.5 cups","fresh lemon juice: 1.5 cups","limoncello: 0.5 cup","kosher salt: 0.125 teaspoon"}	45
643916	https://spoonacular.com/recipeImages/643916-312x231.jpg	jpg	0	6	{pretzels,butter,"cream cheese","lime zest","juice from lime","whipped topping"}	Frozen Mojito Pie	{"In a medium sized bowl mix together the pretzel crumbs and the butter.","Press the pretzels onto the bottom of an 8-inch springform pan, or a round pan lined with plastic wrap.","Freeze the crust for at least one hour.","In your mixers bowl, beat together the cream cheese, sugar, zest, juice, and mint.","Mix until well blended.","Whisk in the whipped topping.","Spoon the filling over the crust.","Freeze for at least 6 hours. Over night is best.","Carefully remove the pie from the pan and top it with some crushed pretzels and thin slices of lime.","Keep it frozen."}	{"finely crushed pretzels: 1.0 cup","butter, melted: 5.0 tablespoons","package cream cheese, softened: 8.0 oz","sugar: 0.75 cup","Zest from large lime: 1.0 large","Juice from large lime (if the limes you are using are really small, use two of t: 1.0 large","finely chopped fresh mint (I like it minty, so I use 3 tbsp. of mint): 3.0 tablespoons","Whipped Topping: 2.0 cups"}	45
651984	https://spoonacular.com/recipeImages/651984-312x231.jpg	jpg	0	4	{"egg yolks","b silken tofu","sesame seeds","d egg whites"}	Mini Tofu Chiffon Cake	{"Cream (A) till pale, thick and creamy.","Add in (B), mix well.","Fold in (C) and mix till no lumps, add 1/2 tbsp black sesame into it and mix well, set aside.","Beat egg whites till frothy, gradually add in the sugar in batches, mix well. Continue beating till egg whites are stiff but not dry. (When the whisk is removed and inverted, the egg white residue does not fall off).","Fold egg whites into the egg yolk mixture with a handwhisk till well combined.","Spoon batter into cupcake liners up to 3/4 full evenly and bake @ 180C for 15 mins then lower temperature to 160C for another 20 mins or skewer comes out clean.","Invert cake immediately on a wire rack to cool completely before unmoulding."}	{"A Egg yolks (I used 70g egg): 4.0 ","Caster sugar: 20.0 g","55ml Corn/canola oil: 55.0 g","B Silken tofu, mashed finely (or blended finely): 110.0 g","55ml Soymilk (sweetened but sugar reduced): 55.0 g","C Superfine flour (I used plain flour - sifted twice): 100.0 g","Black sesame seeds: 0.5 tbsp","D Egg whites: 4.0 ","Caster sugar: 80.0 g"}	45
636875	https://spoonacular.com/recipeImages/636875-312x231.jpg	jpg	0	7	{"chocolate chips","full cream milk","thickened cream","vanilla essence","egg yolks","pink food colouring","candy canes"}	Candy Cane Chocolate Ice Cream	{"Pour milk, cream and essence in a large saucepan over medium-low heat and bring to simmer. Lower heat slightly, add in 100g candy canes and the mint leaves and leave with a lid on top, stirring occasionally, for 15-20 minutes.","Strain the liquid, pressing down on the leaves and candy to extract maximum flavour.","Whisk the yolks and the sugar together until thick, creamy and pale.","Reheat the milk mixture to simmering point, then pour half the mixture into the egg mix, stirring continuously as to avoid scrambled eggs.","Add the hot egg liquid mixture to the remaining milk mixture again, stirring continuously, and cook over low heat for 3-4 minutes or till the custard coats the back of a wooden spoon.","Remove from heat and add in a few drops of food colouring till the custard is a light pink colour.","Strain the custard into a large cool bowl and leave to cool in the fridge, covered in plastic wrap that is touching the surface and preventing a skin from forming.","Chill for 3-4 hours or overnight.","Churn the ice cream in an ice cream machine till creamy and frozen.","Add in chocolate bits and remaining 100g of crushed candy canes throughout the mixture, spoon into a tub and let freeze for 3-4 hours or overnight.","Serve in chilled bowls with extra candy cane goodness!"}	{"white chocolate chips: 100.0 g","full cream milk: 400.0 ml","thickened cream: 300.0 ml","vanilla essence (I used a vanilla bean, split, but it was too strong): 1.0 tsp","fresh mint leaves, washed and dried: 40.0 g","egg yolks: 4.0 large","caster sugar: 150.0 g","Red or pink food colouring: 10.0 servings","candy canes, crushed: 200.0 g"}	45
652017	https://spoonacular.com/recipeImages/652017-312x231.jpg	jpg	0	5	{"cocoa powder",butter,chocolate,"vanilla extract",eggs}	Mint Oreo Brownies	{"Preheat the oven to 350F. Line a 9x13 pan with foil.","In a small bowl. Sift together the flour and cocoa powder.","Whisk in the sea salt and set aside.","In a medium saucepan. Melt the butter and unsweetened chopped chocolate until all the chocolate is melted and the mixture is smooth.","Stir in the sugar and vanilla.","Remove from heat. It will look 'grainy' because of the sugar but don't worry.","Whisk/stir in the eggs one at a time. Beat well after each addition. You should now have a smooth, satin-like mixture.","Add the flour/cocoa and stir until uniform.","Stir in the Oreos.","Pour into prepared pan.","Crush some extra cookies over the top.","Bake for about 35 minutes. A tester should be free of any batter but have a few moist crumbs."}	{"all purpose flour: 1.6666666 cups","cocoa powder: 1.0 cup","sea salt ( I used 1 tsp. ): 0.5 teaspoon","cup ) of butter Cut into pieces: 2.0 sticks","chopped, unsweetened chocolate: 6.0 ounces","cups of sugar ( I reduced mine by ½ ): 3.0 cups","vanilla extract ( I used Kahlua ): 2.0 teaspoons","cups of roughly chopped mint Oreos ( about ): 18.0 ","eggs ( I used 3 ): 4.0 "}	45
157259	https://spoonacular.com/recipeImages/157259-312x231.jpg	jpg	0	4	{"cocoa powder",eggs,"maple syrup","rolled oats"}	Cocoa Protein Pancakes	{"Blend the rolled oats in a blender or food processor until you have a fine powder.","Mix in the cocoa powder.","Blend the ground oats/cocoa powder with the cottage cheese (or quark, if you can find it) and eggs.","Pour the thick batter into a hot, oiled skillet and use the back of a spoon to form round pancakes.","Flip the pancakes once the sides are firm and turning brown..","Serve with maple syrup."}	{"cocoa powder: 1.0 tablespoon","quark or cottage cheese: 1.0 cup","eggs: 3.0 ","maple syrup: 2.0 servings","rolled oats: 1.0 cup"}	15
716414	https://spoonacular.com/recipeImages/716414-312x231.jpg	jpg	0	4	{blueberries,crêpes,raspberries,"raspberry fruit spread"}	Red, White & Blue Crepes: Happy July 4th! @driscollsberry	{}	{"blueberries: 1.0 serving","your favorite crêpes (here's my: 1.0 serving","crumbled feta cheese: 1.0 serving","raspberries: 1.0 serving","raspberry fruit spread or jam: 1.0 serving"}	45
636589	https://spoonacular.com/recipeImages/636589-312x231.jpg	jpg	0	4	{"butternut squash","liquid egg substitute","non-fat milk","bell pepper"}	Butternut Squash Frittata	{"Preheat oven to 350Spray a 10 oz oven safe dish with cooking spray","Add your butternut squash","In a measuring cup add your eggs and milk.","Mix until combined.","Pour over butternut squash.","Sprinkle with pepper and top with cheese.","Bake in oven for 30-35 minutes, until middle is slightly firm","Let it cool for a few minutes"}	{"butternut squash, peeled, seeded, thinly sliced (with a mandoline): 1.0 large","goat cheese: 0.5 oz","liquid egg substitute: 0.5 cup","non-fat milk: 2.0 tbsp","Pepper to taste: 1.0 serving"}	45
634848	https://spoonacular.com/recipeImages/634848-312x231.jpg	jpg	0	4	{"vanilla almond granola","raspberries and mint leaves",raspberries,"vanilla yogurt"}	Berries and Cream Yogurt Parfait	{"Fold together the Alouette Berries & Cream and yogurt in a bowl.","Layer 1 tbsp. granola, 1 tbsp. cheese and yogurt mixture, and 1 tbsp. crushed raspberries in 4 parfait glasses.Repeat layers two more times.","Garnish with raspberries and mint leaves."}	{"French vanilla almond granola: 12.0 tablespoons","package Alouette Berries & Cream Spreadable Cheese: 6.5 oz","each – fresh raspberries and mint leaves for garnish: 4.0 ","fresh raspberries, crushed: 12.0 tablespoons","vanilla yogurt: 1.0 cup"}	45
622598	https://spoonacular.com/recipeImages/622598-312x231.jpg	jpg	0	4	{eggs,basil,milk,pepperoni}	Pittata - Pizza Frittata	{"Pre-heat oven to ~450°F (230°C), top heat only.","On the stove, heat cooking fat in a large oven-safe skillet over medium heat.","Beat the eggs with the milk (again milk is optional), salt, pepper, and any herbs or spices desired.","Add any desired add-ins (other than cheese) to the skillet. For the pittata, we didn't use anything, but this is when you would add your cooked vegetables or raw vegetables that don't require much cooking (e.g. bell pepper).","Pour in the egg mixture and tilt the skillet to ensure it evenly surrounds any add-ins. Now distribute the shredded cheese and pepperoni slices (if using).","Allow the eggs to cook on the stove until the edges of the eggs are set. The center will still be a bit jiggly. Now is a good time to top with Parmesan cheese (be generous!)","Transfer the pan to the hot oven and bake until the eggs are puffed and browned with a firm center.","Remove from oven and let cool for a couple minutes before cutting into wedges."}	{"eggs: 8.0 ","fresh basil: 2.0 servings","milk: 0.5 cup","freshly grated Parmesan cheese: 2.0 servings","pepperoni: 2.0 servings","shredded mozzarella cheese: 0.25 cup"}	30
665734	https://spoonacular.com/recipeImages/665734-312x231.jpg	jpg	0	2	{eggs,zucchini}	Zucchini Chicken Omelette	{"Beat eggs and water in a bowl.","Mix in grated zucchini and season with salt and pepper.","Heat the oil in a small, non-stick skillet. When hot, add half the egg mixture and cook for 1 minute until the egg begins to set. Scatter evenly with half diced chicken.","Cook for a further 1-2 minutes, until the egg is golden underneath, and just set on top. Slide out onto a serving plate, folding it over as you go. Repeat.","Serve the omelette with your favourite salad."}	{"Eggs: 3.0 ","Water: 1.0 tablespoon","Zucchini, grated: 150.0 grams","Salt and pepper to taste: 2.0 servings","Oil: 1.0 tablespoon","Milanese chicken left over, diced: 80.0 grams"}	45
157960	https://spoonacular.com/recipeImages/157960-312x231.jpg	jpg	0	3	{eggs,"portobello mushroom caps",spinach}	Portobello Baked Eggs	{"Turn the oven to broil. Clean mushroom caps and, if desired, lightly scrape the gills out of the underneath of each cap.","Brush mushrooms on both sides with olive oil , and season with salt and pepper.","Place gill side down on a sheet pan and cook for about 3-5 minutes.","Remove from the oven.  Turn the oven down to 350°F.   Turn the mushrooms gill side up and start building.  First, place the spinach into the cap building up the sides and creating a well in the middle, if necessary, to accommodate the egg.","Add some goat cheese and Carefully break one egg into the well of each of the mushroom caps. Now place them back into your 350°F oven and bake for 15 to 17 minutes depending on how well done or sunny-side-up you like your eggs.","Serve immediately."}	{"eggs: 4.0 large","goat cheese, optional: 2.0 oz","olive oil: 3.0 tablespoons","Portobello mushroom caps: 4.0 medium","salt and pepper, to taste: 4.0 servings","spinach, wilted: 8.0 oz"}	20
645733	https://spoonacular.com/recipeImages/645733-312x231.jpg	jpg	0	3	{"pats of butter",ham,bread}	Grilled Ham and Swiss Sandwich	{"Melt butter in skillet.Stack sandwich like so: bread, ham, ham, ham, swiss, bread.","Place sandwich in skillet, let brown.  Adjust heat as needed.","Remove the sandwich briefly from the skillet, add the other piece of butter and let it melt.Flip sandwich over and brown. Cook until cheese is melted.Eat hot."}	{"pats of butter: 2.0 ","Thin Sliced Ham: 3.0 Pieces","Swiss Cheese: 2.0 Slices","White Bread: 2.0 Slices"}	45
661757	https://spoonacular.com/recipeImages/661757-312x231.jpg	jpg	0	3	{"basil leaves","juice of lemon","simple syrup"}	Strawberry Basil Italian Ice	{"To make the simple syrup, combine one cup of water and one cup of sugar in a small sauce pan or microwave safe bowl.","Heat until the sugar has completely dissolved. Cool a  little.","Place all the ingredients in a blender. Puree until smooth.","Pour into 1 large container, or 6 small dishes. Freeze.When ready to serve, remove from the freezer and set on the container for 10 minutes. Then use your spoon to shave away!Make a little over 3 cups, or 6 individual servings."}	{"basil leaves: 0.25 cup","Zest and Juice of lemon: 1.0 ","simple syrup: 1.5 cups","strawberries (Reserve some for garnishing): 400.0 grams"}	45
646515	https://spoonacular.com/recipeImages/646515-312x231.jpg	jpg	0	4	{"chili powder","egg whites","old fashioned oats",scallions}	Healthy Southwestern Oatmeal	{"Bring 1 1/2 c. water to a boil; add the oats. reduce to a simmer, and cook for about 10 minutes, until the mixture is starting to be more oats than water.","Add the scallions and chili powder, and cook until excess liquid is gone.","Add the egg whites, stirring constantly, and cook until the whites are opaque and mixed in.Turn into a serving bowl, add salt and cheddar, and start your day!"}	{"chili powder: 0.5 teaspoon","egg whites: 2.0 ","old fashioned oats: 0.5 cup","reduced fat cheddar cheese: 4.0 tablespoons","Salt to taste: 1.0 serving","scallions, chopped (both white and green parts): 2.0 "}	15
664089	https://spoonacular.com/recipeImages/664089-312x231.jpg	jpg	0	3	{honey,"non-fat milk","peanut butter"}	Turkish Delight	{"Measure all ingredients into a large bowl. Stir until well mixed. Spoon into a buttered 12x9-inch pan. Press out mixture to about 1/2-inch thickness.","Cut into squares while soft. Cover and refrigerate."}	{"honey: 1.0 cup","non-fat dry milk: 2.0 cups","peanut butter: 1.0 cup","powdered sugar: 1.0 cup"}	45
648368	https://spoonacular.com/recipeImages/648368-312x231.jpg	jpg	0	3	{"canned tomatoes","ea. jalapeno pepper","hot sauce"}	Jalapeno Queso With Goat Cheese	{"Mix all ingredients in a glass bowl and slowly heat in the microwave until piping hot.","Salt and freshly ground black pepper to taste."}	{"package Fresh Goat Cheese, such as Chavrie: 5.3 oz","diced tomatoes, drained: 8.0 oz","ea. jalapeno pepper diced: 1.0 ","hot sauce: 2.0 teaspoons"}	45
636603	https://spoonacular.com/recipeImages/636603-312x231.jpg	jpg	0	2	{"butternut squash",milk}	Butternut Squash Soup with Fresh Goat Cheese	{"Peel and remove seeds from the squash cut in large 2 inch pieces.","Place squash in heavy gauge sauce pot and cover with the milk and water.","Bring to a boil and simmer for 20 minutes until very tender.","Add 1 package Chavrie Goat Cheese Pyramid and bring back to a simmer.","Remove from the heat.","Carefully remove squash with a slotted spoon and place in blender.","Add enough of the cooking liquid to cover the squash puree in the blender. Be very careful: you must leave the center cap of the blender off so you do not trap the steam (cover loosely with a towel).","Pour into a 1 gallon sauce pot and keep warm.","Reserve and repeat until all the squash has been pureed.","Adjust to desired consistency with the remaining cooking liquid. Season with salt and pepper.","To serve, ladle the hot soup into the individual soup bowls and top with a dollop of Chavrie Goat Cheese Pyramid garnish with fresh herbs."}	{"Chavrie® Goat Cheese Pyramid, Original (reserve 1 pkg. to garnish): 10.6 oz","butternut squash: 1.0 ","water: 0.5 qt","milk: 0.5 qt"}	45
644953	https://spoonacular.com/recipeImages/644953-312x231.jpg	jpg	0	3	{"pizza shell",pesto,tomatoes}	Goat Cheese Pesto Pizza	{"Preheat oven to 400F.","Spread pesto evenly over the top of the pizza crust.","Sprinkle diced tomato over pesto.","Top with crumbled goat cheese","Bake in oven for 12-15 minutes until pizza crust edges begin to brown.","Cut in wedges and serve"}	{"prepared pizza shell, 14 inches: 1.0 ","pesto: 1.0 cup","diced Tomatoes: 1.0 cup","crumbled goat cheese, Alouette Provencal variety: 1.0 package"}	45
633165	https://spoonacular.com/recipeImages/633165-312x231.jpg	jpg	0	3	{avocado,bread,butter}	Avocado Tomato & Mozzarella Panini	{"Top 4 slices of bread with a layer of mozzarella, tomato, avocado slices and another layer of mozzarella.","Spread a little butter on both outsides of the sandwiches and grill until bread is toasted and cheese is melted.","Serve warm and enjoy!"}	{"ripe avocado sliced: 1.0 ","french bread: 8.0 slices","grated mozzarella about: 0.5 cup","butter for outside of panini: 4.0 servings","thin sliced tomatoe: 1.0 "}	45
633167	https://spoonacular.com/recipeImages/633167-312x231.jpg	jpg	0	3	{avocado,bread,butter}	Avocado Tomato & Mozzarella Panini/sandwiches	{"Top 4 slices of bread with a layer of mozzarella, tomato, avocado slices and another layer of mozzarella.","Spread a little butter on both outsides of the sandwiches and grill until bread is toasted and cheese is melted.","Serve warm and enjoy!"}	{"ripe avocado sliced: 1.0 ","french bread: 8.0 slices","grated mozzarella about: 0.5 cup","butter for outside of panini: 4.0 servings","thin sliced tomatoe: 1.0 "}	45
661522	https://spoonacular.com/recipeImages/661522-312x231.jpg	jpg	1	2	{parsley,sherry}	Steak With Blue Cheese Sherry Sauce	{"Combine Sherry and oil in a small sauce pan. Bring to a boil and cook until the alcohol has burned off.Reduce heat to a low simmer and add the blue cheese; whisk until creamy.","Brush steaks with olive oil and grill 1 minute - 90 seconds on each side.Warm up sauce and add chopped parsley.","Pour sauce over steaks and serve."}	{"blue cheese crumbles: 3.0 tablespoons","Olive Oil, plus extra for brushing steaks: 2.0 tablespoons","parsley, finely chopped: 2.0 teaspoons","Sherry (inexpensive cooking Sherry is okay!): 2.0 tablespoons","top round: 0.6666667 pound"}	45
636458	https://spoonacular.com/recipeImages/636458-312x231.jpg	jpg	1	3	{bacon,blueberries,eggs}	Bunny Eggs Kids Breakfast	{"Cook bacon in large skillet until crisp.","Remove bacon from skillet, reserving 1 tablespoon drippings in skillet.","Drain bacon on paper towels.","Add 3 eggs to reserved drippings; cover. Cook 4 to 6 minutes or until whites are opaque and completely set and yolks are beginning to thicken around edges.","Remove eggs to individual serving plates; keep warm. Repeat with remaining eggs.For each bunny, place 2 bacon strips on egg for ears.","Cut cheese strips in half to create whiskers; add blueberries for eyes."}	{"bacon: 12.0 slices","fresh blueberries: 12.0 ","eggs: 2.0 extra large","mild cheddar cheese, cut into thin strips: 2.0 large slices"}	45
715538	https://spoonacular.com/recipeImages/715538-312x231.jpg	jpg	0	3	{"bow tie pasta","recipe makers chicken bruschetta pasta","pork chops"}	What to make for dinner tonight?? Bruschetta Style Pork & Pasta	{"wash and rinse pork chops and place into the skillet.cut them into bite sized pieces and add half of the Basil Garlic simmer sauce.boil your water and start working on cooking your bow-tie pasta.when you have finished with boiling and draining your pasta, add it to the pork along with the rest of the Basil Garlic Simmering Sauce, mixing lightly.Next you will top with the Chunky Bruschetta Finishing Sauce, cover with Parmesan, and cover. Cooking on low heat 2 to 3 minutes or until heated through."}	{"bow tie pasta: 3.0 cups","Parmigiano Reggiano: 0.5 cup","Kraft Recipe Makers Chicken Bruschetta Pasta: 5.0 servings","pork chops: 1.5 lb"}	35
654681	https://spoonacular.com/recipeImages/654681-312x231.jpg	jpg	0	2	{"chicken broth",polenta}	Parmesan Polenta	{"Cut polenta into large pieces and heat with broth in medium saucepan over medium-low heat about 5 minutes, mashing and stirring polenta as it cooks until smooth.","Add cheese and stir until melted, about 1 minute. Season to taste with pepper.This recipe yields 6 servings."}	{"Freshly-ground black pepper to taste: 1.0 serving","chicken broth: 1.0 cup","tube of prepared polenta: 24.0 oz","grated Parmesan cheese: 1.0 cup"}	45
642777	https://spoonacular.com/recipeImages/642777-312x231.jpg	jpg	0	3	{figs,"naan bread",pesto}	Fig and Goat Cheese Pizza With Pesto	{"Spread the pesto over each piece of naan bread evenly.Top with the figs and then crumble goat cheese on top.","Place on the grill on low heat for about 5-7 minutes - or until crust is lightly crisp and the goat cheese has melted. So easy - and really so delicious.For a little more texture - you can sprinkle pine nuts on top as well."}	{"Figs, Dried, chopped, medium fine: 5.0 medium","goat cheese: 0.75 cup","naan bread: 4.0 pieces","pesto: 1.0 cup"}	15
665823	https://spoonacular.com/recipeImages/665823-312x231.jpg	jpg	0	2	{"plain/flavour yogurt",blueberries}	Melt Your Heart	{"Give the yogurt a good stir and spoon it into the mini heart shape ice-cube tray.","Freeze it for at least 2 hours or more till harden. (you can prepared this 1 day ahead).","Rinse and cut the strawberries into halves, serve with blueberries or any fruits of your choice together with a few yogurt cubes in short glass."}	{"Plain/Flavour Yogurt: 200.0 milliliters","Fresh Blueberries: 1.0 Handful","Strawberries: 10.0 "}	45
641732	https://spoonacular.com/recipeImages/641732-312x231.jpg	jpg	0	2	{"vanilla yogurt","dulce de leche"}	Dulce De Leche Swirled Amaretto Frozen Yogurt	{"Drained the yogurt overnight","Mix the amaretto cream into the yogurt & churn in your ice cream maker as according to the manufacturer's instruction.","Warm the dulce de leche, or caramel in the microwave for 30 seconds. When yogurt is done churning, layer drizzles of dulce de leche into the yogurt and store in the freezer."}	{"vanilla Balkan style yogurt, 650g: 1.0 tub","amaretto cream (keep cold): 2.0 tablespoons","dulce de leche, or caramel, or 3 caramel squares: 2.0 tablespoons"}	45
715574	https://spoonacular.com/recipeImages/715574-312x231.jpg	jpg	0	2	{"vanilla ice cream",milk}	Homemade Strawberry Shake	{"Add the strawberries, whole milk and vanilla ice cream to a blender, and blend until smooth.","Pour into cold glasses that have been kept in the freezer.Return the shakes to the freezer for about 5 minutes, or until they are thick.Top with whipped cream and sliced strawberries."}	{"strawberries, washed and sliced: 10.0 large","vanilla ice cream: 2.5 cups","whole milk: 2.0 cups"}	45
661843	https://spoonacular.com/recipeImages/661843-312x231.jpg	jpg	0	1	{marshmallows}	Strawberry Marshmallow Mousse	{"Put all but 3 strawberries into a pan along with the water and the sugar. Over a medium heat, cook strawberries until soft enough to mash, about 3 minutes. Take off the heat and squash the berries, using a fork, until pulpy.","Add the marshmallows, then stir them into the hot strawberries until they dissolve. Leave to cool.","Whip the cream until it holds its shape. Fold the cream into the cooled strawberry mix, then spoon into one bowl or separate pots and chill for about 2 hours, or until set.","Cut the reserved strawberries in half and use to decorate."}	{"Fresh strawberries, halved if large: 280.0 grams","Vanilla sugar: 25.0 grams","Water: 100.0 milliliters","Mini marshmallows: 140.0 grams","Double cream: 200.0 milliliters"}	45
642058	https://spoonacular.com/recipeImages/642058-312x231.jpg	jpg	0	3	{"cream cheese","strawberry jam","whipped topping"}	Easy Peasy Strawberry Dessert	{"In the bowl of your mixer, mix together the cream cheese and the jam until well blended, about a minute or so.","Gently stir in the whipped topping.","In four ramekins spoon in half of the sliced strawberries.","Pour the cream cheese mixture over the strawberries.","Top with remaining strawberries.","Serve immediately or refrigerate until ready to use."}	{"(half of 8 oz. package) Cream Cheese, softened: 4.0 ounces","Strawberry Jam: 0.5 cup","Whipped Topping: 1.0 cup","sliced strawberries, divided: 1.0 cup"}	45
635040	https://spoonacular.com/recipeImages/635040-312x231.jpg	jpg	0	3	{"half& half","coffee- try starbucks via","vanilla extract"}	Bittersweet Chocolate Ice Cream	{"Prep your ice cream maker according to the manufacturers directions.In a medium sauce pan, heat the half & half until warm- not hot.In a bowl, whisk the egg yolks until blended.","Add the sugar and about 1/2 of the warm half and half. Stir to combine well and add the mixture back to the saucepan.","Whisking briskly while combining.Cook over medium heat until the mixture coats the back of a silicone spatula (about 10-12 minutes).","Remove from heat and add the chocolate and coffee, stir to melt and combine thoroughly.","Place the pan with the custard in an ice bath to cool, stirring occasionally, until it reaches room temperature.","Add the whipping cream and vanilla","Pour into another container and chill until cold -several hours-or you are ready pour into the ice cream maker.Freeze in the ice cream maker according to the manufacturers directions. Makes about a quart."}	{"HALF& HALF: 2.0 cups","Heavy Whipping Cream: 1.0 cup","Instant Coffee- try Starbuck's Via: 0.25 teaspoon","vanilla extract: 2.0 teaspoons"}	45
661741	https://spoonacular.com/recipeImages/661741-312x231.jpg	jpg	0	2	{"chocolate chips- handful","sourdough bread"}	Strawberry and Chocolate Chip Panini	{"Open up the slices of sourdough bread","Brush it wit some olive oil on either side","Add a layer of strawberries and chocolate chips","Put it in the panini press!","Serve it hot with a side of fresh cut berries!"}	{"Sliced strawberries: 1.0 serving","Chocolate chips- handful: 1.0 serving","sourdough bread: 2.0 slices","Olive oil and brush: 1.0 serving"}	45
716424	https://spoonacular.com/recipeImages/716424-312x231.jpg	jpg	0	2	{"basil leaves",honey}	Strawberry Basil Sorbet (no Ice Cream Maker Necessary!)	{}	{"about finely chopped basil leaves: 0.25 c","basil oil (optional): 1.0 t","honey or agave: 2.0 T","organic strawberries (my bag was 12 oz; 16 oz would be better!), thawed for about a 1/2 hour: 1.0 bag"}	45
646191	https://spoonacular.com/recipeImages/646191-312x231.jpg	jpg	0	5	{"sprouted wheat bread","swiss cheese",kale,thyme,"dijon mustard"}	Ham and Swiss Panini With Mushrooms and Kale	{"Heat a large skillet over medium heat and spray with cooking spray.","Add mushrooms and cook 3  5 minutes until tender.","Add kale and thyme and cook another 2  3 minutes to lightly wilt kale. Season with salt and pepper to taste.","Spread 1 teaspoon Dijon mustard over one slice of bread.","Layer ham and Swiss cheese, then half the mushroom and kale mixture. This will pile on, but thats what you want.","Top sandwich with another slice of bread and lightly spray with olive oil cooking spray.","Place the slide with cooking spray down on a panini grill, then lightly spray the other side of the bread with cooking spray.","Grill 4  5 minutes until cheese melts and bread is toasty brown.","Repeat with remaining ingredients."}	{"sprouted wheat bread: 4.0 slices","low fat swiss cheese: 2.0 slices","mushroom, sliced: 4.0 ounces","kale, chopped: 4.0 cups","thyme, minced: 1.0 tablespoon","Dijon mustard: 2.0 teaspoons"}	45
633324	https://spoonacular.com/recipeImages/633324-312x231.jpg	jpg	0	5	{bacon,"sea scallops","whipping cream","dijon mustard","maple syrup"}	Bacon Scallops	{"Preheat oven to 350-degrees.","Arrange bacon slices on baking sheet.","Bake until pale golden, about 8 minutes.","Cut each slice crosswise in half. Cool.","Wrap 1 bacon piece around sides of each scallop and secure with a toothpick.","Preheat oven to 400-degrees.","Place scallops on baking sheet and bake until cooked through, about 10 minutes.","Meanwhile, boil cream in heavy large skillet until reduced to 3/4 c., about 3 minutes.","Add mustard and syrup and boil until thickened to sauce consistency, about 3 minutes. Season to taste with salt and pepper.","Remove toothpicks from scallops. Spoon sauce evenly onto 4 small plates.","Arrange scallops decoratively atop sauce.","Sprinkle with chives and serve."}	{"10 Bacon slices: 10.0 slices","Sea scallops: 20.0 large","Whipping cream: 1.0 cup","Dijon mustard: 2.0 tablespoons","Pure maple syrup: 2.0 tablespoons","Snipped fresh chives: 4.0 servings"}	45
633376	https://spoonacular.com/recipeImages/633376-312x231.jpg	jpg	0	4	{"king arthur special",gluten,yeast,"malt extract syrup"}	Bagels	{"Mix dry ingredients. Dissolve malt syrup in the water, then dissolve yeast in the malt/water.","Mix and shape as in sourdough recipe (see Sourdough Bagels recipe).","Let rise in fridge 12 to 15 hours.","Remove from fridge and prepare boiling water, heat oven etc. Bagels should be ready to boil by the time you are ready. They won't need the couple hours of additional rising at cool room temp.","50-50 Whole Wheat version:Same, but use half whole wheat flour and increase the water to 1 1/2 cups."}	{"King Arthur Special For Machines flour: 1.0 pound","gluten: 2.0 tablespoons","kosher salt (1 ½ to 2): 1.5 teaspoons","instant yeast: 1.5 teaspoons","lukewarm water: 1.25 cups","malt extract syrup (1 to 2) (or mix dry malt extract with the: 1.0 tablespoon"}	45
642835	https://spoonacular.com/recipeImages/642835-312x231.jpg	jpg	0	4	{butter,"juice of lemon",sole,"rosé wine"}	Filet Of Sole With A Brown Butter Rose Sauce	{"Wash and pat fillets dry with paper towels","Heat butter over medium high heat until bubbly in a large skillet","Pile flour on a plate, dredge fillets in flour and shake off any excess","Slip floured fillets into bubbly butter, when slightly brown on one side, flip over and allow the other side to brown","When brown on both sides remove fillets","Pour wine and lemon juice into the butter","Allow to cook over medium high heat until it is reduced by 1/2Spoon sauce over fillets","Sprinkle with chives.","Serve and enjoy!"}	{"butter: 3.0 tablespoons","flour: 2.0 ounces","chopped fresh chives: 2.0 teaspoons","juice of lemon: 1.0 ","fresh fillet of sole: 1.0 pound","rosé wine: 3.0 tablespoons"}	45
639337	https://spoonacular.com/recipeImages/639337-312x231.jpg	jpg	0	5	{bacon,"chorizo links",garlic,pasta,peas}	Chorizo, Bacon, Mushroom and Pea Pasta	{"Put the pasta in a pan and then boil the kettle","While the kettle is boiling chuck the Chorizo and bacon in a frying pan with the oil on a high heat.","Put the boiling water from the kettle in the pan of pasta and add salt, pepper and a dash of olive oil. Simmer until done.Once the bacon looks like it is about to get crispy add the mushrooms and the garlic. Keep turning at this point to make sure the bacon doesn't burn.Just before you drain the past throw the peas in the frying pan with the bacon and turn the heat down to low.","Drain the pasta and then add the pasta to the frying pan and coat it in the lovely orangey/red oil from the chorizo.","Serve with some freshly ground pepper."}	{"bacon: 12.0 slices","chorizo links: 6.0 ","garlic, chopped: 2.0 Cloves","mushrooms: 12.0 ","olive oil: 1.0 tablespoon","pasta: 1.0 pound","peas: 1.0 cup"}	45
645706	https://spoonacular.com/recipeImages/645706-312x231.jpg	jpg	0	6	{"alfalfa sprouts",bread,"cheddar cheese",eggplant,hummus,"lettuce leaves"}	Grilled Eggplant Sandwich	{"Heat up a small grill. Slice the eggplant into thin slices and spray each slice lightly with cooking spray. Grill the slices for approximately 2 minutes on each side or until the eggplant begins to brown. Grill the mushroom slices for approximately 1 minute on each side-they burn easily, so be careful.","Remove eggplant and mushrooms from grill.","Spread the hummus on the toast, arrange all bread on a cookie sheet.","Layer each piece of bread with eggplant, mushrooms, and a sprinkle of the cheese.","Put the pieces of bread together in sandwich form and bake in a 400 degree oven for about 5 minutes or until cheese is melted.Open the sandwiches and stick lettuce and alfalfa sprouts inside."}	{"alfalfa sprouts: 3.0 servings","whole-wheat bread, lightly toasted: 6.0 slices","cheddar cheese: 3.0 ounces","eggplant: 1.0 medium","hummus: 6.0 tablespoons","lettuce leaves: 3.0 servings","mushrooms, sliced: 3.0 ounces"}	45
641890	https://spoonacular.com/recipeImages/641890-312x231.jpg	jpg	1	2	{eggs,milk}	Easy Cheesy Scrambled Eggs	{"Scramble eggs with milk or cream and some salt and pepper.","Cook in a nonstick skillet over medium heat, stirring to lift the cooked eggs from the bottom of the pan as they cook.","When the eggs are just about cooked, toss in jack cheese and cook for about 1-2 minutes more just to melt the cheese.","Serve as is, over toast, or in a tortilla."}	{"eggs: 8.0 large","milk or cream: 0.25 cup","salt and pepper: 4.0 servings","shredded jack cheese: 0.5 cup"}	45
642722	https://spoonacular.com/recipeImages/642722-312x231.jpg	jpg	0	3	{"fettuccine pasta",peas,"ricotta cheese"}	Fettuccine With Smashed Peas	{"Cook the pasta according to package directions.","Meanwhile, pulse the thawed peas in a food processor or blender until chopped (take care not to puree).","Add  cup ricotta, salt and pepper to the peas and pulse to mix everything together.","Drain the pasta and reserve  cup of the cooking water.","Put the pasta back in the pot.","Add the peas to the cooking water and to the pot and toss together.","Arrange the pasta in a large bowl or platter, and top with the remaining ricotta and sprinkle with the chives.","Drizzle the olive oil over top.","Serve in individual bowls, making sure to distribute the ricotta cheese topping,"}	{"fettuccine pasta: 1.0 pound","package frozen peas, thawed: 16.0 ounce","ricotta cheese: 0.75 cup","coarse salt: 1.25 teaspoons","black pepper: 0.25 teaspoon","chopped fresh chives: 1.0 tablespoon","extra-virgin olive oil: 1.0 tablespoon"}	45
645818	https://spoonacular.com/recipeImages/645818-312x231.jpg	jpg	0	4	{"portobello mushroom caps","baby arugula","squeezed lemon juice",parmigiano-reggiano}	Grilled Portobello Salad With Shaved Parmigiano-Reggiano	{"Gently clean the mushroom caps then rub each with a little Extra virgin olive oil and sprinkle both sides with salt and pepper. Grill over medium heat until just cooked through, a couple minutes a side.","Remove from grill.","Prepare the dressing.","Whisk together 2 tablespoons extra virgin olive oil and the lemon juice. Season to taste with salt and pepper.","To serve, pour just enough dressing on the arugula to gently coat it. Pile the arugula on two plates. Slice the mushrooms and arrange over the arugula. Top each with a good amount of fresh shaved Parmigiano-Reggiano."}	{"Portobello mushroom caps: 2.0 ","extra virgin olive oil: 2.0 servings","sea salt, to taste: 2.0 servings","freshly-ground black pepper, to taste: 2.0 servings","fresh baby arugula: 1.0 small bunch","fresh squeezed lemon juice: 2.0 teaspoons","Parmigiano-Reggiano, to taste: 2.0 servings"}	45
652130	https://spoonacular.com/recipeImages/652130-312x231.jpg	jpg	0	5	{butter,morels,cornstarch,"tagliatelle pasta",garlic}	Mixed Mushroom Sauce Over Tagliatelle Pasta	{"In a 12\\" pan, melt the butter in the oil, add the rehydrated mushrooms and saute at low-medium heat for several minutes.","Add the fresh mushrooms and continue sauteing at low-medium heat until they have softened and the sauce is slightly reduced.","Add the garlic and continue for 2 minutes.","Add the cornstarch to the mushroom liquid, mix and put back in the pan to thicken the sauce. Cook this down for about 10 minutes until sauce has right consistency.","About the time when you add the mushroom liquid to the pan, place the pasta in salted and oiled boiling water and cook according to package directions for al dente, usually about 8-10 minutes."}	{"unsalted butter: 1.0 oz","olive oil infused with white or black truffel essence: 3.0 oz","dried Morels, re-hydrated in 4 oz warm water for 20 to 30 minutes, rough chopped. Save the liquid for the sauce: 1.0 oz","fresh Shitake mushrooms, sliced 1/4 \\". We added 3 left over Porcinis: 8.0 oz","cornstarch: 1.5 t","tagliatelle pasta: 8.0 oz","garlic, sliced thin: 3.0 cloves","fresh chives, chopped: 1.0 T","Salt, freshly ground black pepper and Parmesan cheese to suit at table: 2.0 servings"}	45
641854	https://spoonacular.com/recipeImages/641854-312x231.jpg	jpg	0	3	{"baking powder",eggs,"cinnamon and vanilla"}	Easy Blueberry Muffin	{"Pre-heat oven to 400F","Combine the dry ingredients: sift the flour, baking powder, cinnamon and  cup brown sugar together in a bowl and make a well (reserve the rest of the brown sugar for topping)Stir in the wet ingredients: add in the eggs, oil, vanilla, and yogurt and stir with a wire whisk till just mixed, do not over-mix; fold in the blueberries","Grease a muffin pan or use paper baking cases, drop the batter in - to about 2/3rds full - in each baking case/mold; sprinkle remaining brown sugar on top for a crispy sweet skin","Bake in a 400F oven for about 15-20 minutes, till a toothpick inserted in the center comes out clean","Cool on a wire rack for a few minutes and enjoy warm"}	{"all purpose flour: 2.0 cups","baking powder: 1.0 tablespoon","brown sugar: 0.75 cup","canola oil: 0.5 cup","eggs: 2.0 ","each of cinnamon and vanilla (or more if preferred): 0.5 teaspoon"}	45
643972	https://spoonacular.com/recipeImages/643972-312x231.jpg	jpg	0	4	{bisquick,cinnamon,eggs,milk}	Fruit Crepe	{"Mix all ingredients thoroughly in medium bowl. Fry in large frying pan (greased). Batter should be 6 to 8 inches in diameter. Cook on medium heat until golden brown. Flip then add fruit. Apple, cherry, blueberries, etc. Topping Cool Whip."}	{"Bisquick: 2.0 cups","cinnamon: 3.0 tablespoons","Eggs beaten: 3.0 ","cold milk: 1.0 cup","Sugar: 0.5 cup"}	45
656663	https://spoonacular.com/recipeImages/656663-312x231.jpg	jpg	0	3	{"cherry jam",egg,"pie dough"}	Pop Tart	{"Pre-heat oven to 350 degrees.Line a baking sheet with parchment paper or silpat","Floor your board very well.","Roll your pie dough out to to 12X","Using a floured knife, cut the dough into mini-rectangles that are about 3X4 inches.   You should have 8 mini-rectangles  enough to make a total of 4 pop tarts.","Place about 2 tablespoons of jam in the middle of 4 of the mini-rectangles.Then, place the jam-less rectangles on top of the jam-filled rectangles","Press the edges of the tarts with a floured fork to seal the edges.Poke a couple of small holes on top of the tarts with your fork to allow steam to escape.Lightly brush the tops of the tarts with the egg wash.Then sprinkle each tart with sugar.","Place in oven for about 20-25 minutes, or until the tarts are brown along the edges and the jam has oozed out a bit!Cool for about 5 minutes and then eat with tea!"}	{"Cherry Jam (or whatever jam you like): 8.0 tablespoons","egg: 1.0 ","granulated sugar: 1.0 tablespoon","Pie dough: 1.0 ","water: 1.0 teaspoon"}	45
632305	https://spoonacular.com/recipeImages/632305-312x231.jpg	jpg	0	4	{"baking powder",milk,eggs,butter}	Amazingly Fluffy Waffles	{"Grease and heat waffle iron as directed by manufacturer.","In a large bowl, stir flour, baking powder, salt, and sugar.","Individually add milk, beaten egg yolks, and butter.","Beat egg whites until stiff. Gently fold into mixture.","When waffle iron is heated, pour some mixture into center and spread to within 1 inch of edge.","Bake as directed. .","When cooked, loosen from waffle iron and serve immediately"}	{"flour, shifted: 1.5 cups","baking powder: 3.0 teaspoons","salt: 0.5 teaspoon","sugar: 2.0 teaspoons","milk: 2.0 cups","eggs, separated: 2.0 ","butter or margarine, melted: 0.25 cup"}	45
657768	https://spoonacular.com/recipeImages/657768-312x231.jpg	jpg	0	5	{"baking powder","egg yolk",milk,raisins,butter}	Raisin Scones	{"Preheat oven to 400 degrees F. Lightly grease baking sheet.Sift flour and baking powder into a med. bowl. Rub butter and sugar into flour to form a fine crumble. Make a well in center, add milk and raisins. Knead gently together, do not over mix. Dough will be sticky.On generously floured surface, roll out to 3/4 inch thickness.","Cut into 2 1/2 inch rounds with a cookie cutter. Alternatively, you can scoop dough with a spoon and shape into rounds.","Transfer to baking sheet, brush tops with yolk. Allow to stand for 10 mins.","Bake in preheated oven until risen and tops are golden, 12 to 15 mins."}	{"baking powder: 4.0 tsp","egg yolk, beaten: 1.0 ","all-purpose flour: 1.75 cups","milk: 0.6666667 cup","raisins: 0.5 cup","sugar: 5.0 tbsp","unsalted butter, softened: 5.0 tbsp"}	45
654495	https://spoonacular.com/recipeImages/654495-312x231.jpg	jpg	0	4	{"baking powder",egg,margarine,milk}	Pancakes	{"Beat egg until fluffy.","Add milk and melted margarine.","Add dry ingredients and mix well.","Heat a heavy griddle or fry pan which is greased with a little butter on a paper towel.The pan is hot enough when a drop of water breaks into several smaller balls which 'dance' around the pan.","Pour a small amount of batter (approx 1/4 cup) into pan and tip to spread out or spread with spoon.When bubbles appear on surface and begin to break, turn over and cook the other side."}	{"baking powder: 4.0 teaspoons","egg: 1.0 ","all-purpose flour – sifted: 2.0 cups","margarine , melted: 2.0 tablespoons","milk: 125.0 milliliters","salt: 0.5 teaspoon","sugar: 1.0 tablespoon"}	45
639120	https://spoonacular.com/recipeImages/639120-312x231.jpg	jpg	0	4	{"rolled oats","cocoa powder","sea salt",milk}	Chocolate Oatmeal	{"In a medium pot, bring water to a boil.","Add Vanilla Sugar and Cocoa Powder.","Stir in Oats and Sea Salt.","Reduce heat to low and simmer until the oats are tender, ~5 minutes.","Remove from heat and stir in milk.","Serve with Extra milk, Sea Salt or Vanilla Sugar for garnish, as needed."}	{"Rolled Oats: 1.5 cups","Vanilla Sugar: 0.25 cup","Cocoa Powder: 0.25 cup","water: 1.75 cups","Sea Salt (I recommend Espresso Brava): 1.0 pinches","milk: 0.5 cup"}	45
657916	https://spoonacular.com/recipeImages/657916-312x231.jpg	jpg	0	4	{milk,peaches,"greek yogurt",raspberries}	Raspberry White Peach Smoothie	{"Blend together the yogurt, raspberries and milk to desired consistency.","Add the white peach pieces and ice cubes and mix.","Add sugar to taste as desired."}	{"ice cubes: 5.0 large","milk: 1.5 cups","white peaches: 2.0 ","plain Greek yogurt: 0.25 cup","fresh raspberries: 0.5 cup","sugar: 2.0 tablespoons"}	5
633969	https://spoonacular.com/recipeImages/633969-312x231.jpg	jpg	0	3	{"pancake batter",banana,"dessicated coconut"}	Banana & Coconut Pancakes With Palm Sugar Syrup	{"Pour water and a palm sugar block into a pot and heat over moderate heat until the block is fully dissolve and slightly thickened. Set aside.","Add dessicated coconut into the pancake batter and stir to combine.","Slice the banana into 1/4 inch thick. Set aside.","Set the pan over moderate heat.","Pour a thin layer of oil over the pan.","When the oil is heated, place a slice of banana first and pour about a tablespoon full of batter over the banana.","When the batter starts to bubble, flip the pancake to the other side. Cook until golden brown.","Serve the banana side up with warm palm sugar syrup."}	{"pancake batter: 1.0 cup","banana: 1.0 ","dessicated coconut: 2.0 tablespoons","Oil to grease pan: 6.0 servings","palm sugar: 225.0 grams","water: 1.0 cup"}	45
662665	https://spoonacular.com/recipeImages/662665-312x231.jpg	jpg	0	3	{milk,muesli,"vanilla yoghurt"}	Swiss Bircher Muesli	{"Put Muesli in a bowl","Pour milk to cover the muesli and mix in yoghurt","Cover and refigerate for a few hours or overnight","When ready to eat, if the mixture is too thick, loosen with milk.Grate apple and stir into the muesli mix",Eat}	{"Apple: 1.0 ","Milk: 0.5 cup","muesli: 0.5 cup","plain or vanilla yoghurt: 3.0 tablespoons"}	45
632577	https://spoonacular.com/recipeImages/632577-312x231.jpg	jpg	0	5	{"tsp all spice",cinnamon,"pancake mix","tsp vanilla extract","whipped cream"}	Apple Pie Pancakes	{"Preheat Oven to 400 degrees Fahrenheit.Peel Green Apples. Core apple and thinly slice apple in  inch slices.","Place on baking sheet.","Sprinkle with brown sugar and cinnamon.","Place in oven and bake for 10 minutes.","Heat frying pan to ,medium high.Meanwhile follow instructions on box to make pancake batter, to make about 10-12 pancakes.","Add 1 TSP vanilla extract, 2 TSP cinnamon and all spice and mix together. Scoop about  cup batter onto frying pan and quickly place 2 slices of apple onto pancake.Cook pancake until golden brown, about 30 seconds. Flip over and cook until golden brown on the other side.","Serve and garnish with more cinnamon and whipped cream."}	{"TSP All Spice: 1.0 ","TSP Brown Sugar: 2.0 ","cinnamon: 0.75 teaspoon","TSP Cinnamon: 2.0 ","granny smith apples: 2.0 ","Pancake Mix ( Make a pancake batch): 10.0 ","TSP Vanilla Extract: 1.0 ","Whipped Cream: 4.0 servings"}	45
715419	https://spoonacular.com/recipeImages/715419-312x231.jpg	jpg	0	4	{"cayenne pepper","regular chicken wings",garlic,"louisiana hot sauce"}	Slow Cooker Spicy Hot Wings	{"Yes, these are called SPICY hot wings for a reason. I like adding the brown sugar to give them a little sweeter taste, but it is by far a delicious spicy recipe more than anything.To get started, mix the brown sugar, crushed garlic, hot sauce, and cayenne pepper into a medium mixing bowl.","Mix well and then set aside.Take the cooking spray and spray the entire inside portion of the slow cooker AND also the wings. (Spraying the wings before you grill, bake, or cook chicken keeps the flavor and makes them super juicy. TRUST ME.)Take the wings and add them into the mixing bowl with your spices and toss to get a good even coat over the wings.","Place in the slow cooker on low for 4 hours. After 4hours, remove carefully and place on a prepared cookie sheet.","Place in the oven under broiler setting for 4-6 minutes, allowing the wings to get a little crisp.","Serve immediately with a little blue cheese dressing and celery."}	{"brown sugar: 0.5 cup","cayenne pepper: 1.0 tsp","regular chicken wings: 2.0 pounds","crushed garlic: 1.0 Tbsp","Louisiana Hot sauce: 0.5 cup"}	14
655540	https://spoonacular.com/recipeImages/655540-312x231.jpg	jpg	0	5	{"five-spice powder",butter,ham,onions,pecans}	Pecan-Baked Ham	{"Preheat the oven to 35","In a small bowl, mix the pecans, sugar, and five-spice powder with the butter until you have a fine, crumbly mixture. Rub generously over the ham, patting the crust with your hands.Scatter the onions in the bottom of a heavy roasting pan and add about 2 cups water.","Place the ham on the bed of onions. Slide the pan into the oven and roast for about 2 hours, checking to make sure theres still liquid in the pan. As the water evaporates, add a bit more. The ham is done when a nice glaze forms on the outside.The pecan mixture and the water in the pan will create their own sauce to pour over the ham after youve sliced it into beautiful pink rounds. If the sauce seems too thin, just pour into a saucepan and reduce it."}	{"Chinese five-spice powder: 1.0 tablespoon","brown sugar: 1.0 cup","butter: 3.0 tablespoons","good quality cooked ham: 5.0 pound","onions, chopped: 2.0 medium","Chopped pecans, chopped medium fine: 4.0 tablespoons"}	45
634251	https://spoonacular.com/recipeImages/634251-312x231.jpg	jpg	0	4	{almonds,butter,cayenne,"coarsely-chopped rosemary leaves"}	Bar Nuts	{"Preheat oven to 350 degrees.On a baking sheet spread almonds and toast in middle of oven until golden, about 12 to 15 minutes. While nuts are toasting, in a large bowl toss together remaining ingredients. Toss nuts with rosemary mixture.This recipe yields 4 cups."}	{"Unsalted almonds: 1.0 pound","butter: 30.0 grams","Cayenne: 1.0 teaspoon","Coarse salt: 3.0 teaspoons","Dark brown sugar - (firmly packed): 3.0 teaspoons","Coarsely-chopped fresh rosemary leaves: 3.0 tablespoons"}	45
1515523	https://spoonacular.com/recipeImages/1515523-312x231.jpg	jpg	0	4	{"chicken thighs","onion powder","bbq sauce",garlic}	Instant Pot BBQ Chicken Thighs	{"Add water to the bottom of the instant pot.","Place the trivet and then place the chicken around the trivet. Top the chicken with garlic","Cook on manual high for 8 minutes and then 10 minutes natural release. ","Add seasonings and brown sugar to BBQ sauce and smother the chicken thighs. ","Place in the broiler for 4-6 minutes to make a delicious glaze. ","Serve with a garlic butter parmesan noodles. "}	{"water: 1.0 cup","chicken thighs: 5.0 ","pepper: 1.0 tsp","onion powder: 1.0 tsp","BBQ sauce (Your favorite!): 1.0 cup","minced garlic: 1.0 tbsp","brown sugar: 1.0 tbsp"}	25
635182	https://spoonacular.com/recipeImages/635182-312x231.png	png	0	6	{"skin-on chicken drumsticks",blackberries,"balsamic vinegar",rosemary,butter,"grain mustard"}	Blackberry Balsamic Drumsticks	{"Place blackberries, butter, water, rosemary, sugar and vinegar in a small saucepan.","Cook over medium high heat stirring occasionally until slightly reduced.  About 10 -15 minutes.","Remove from heat and stir in mustard and salt and pepper.","Leave marinade to cool.","Place drumsticks in a large zip lock bag,","Pour cooled marinade over top and seal.  Toss to coat.","Place mixture in the fridge and marinate for 24 hours.","When ready to cook, preheat oven to 375","Arrange drumsticks on a cookie sheet coated in tin foil.","Cook for 25 minutes, turning once.","Serve hot with preferred side."}	{"skin-on chicken drumsticks: 6.0 ","fresh blackberries, rinsed: 1.0 cup","balsamic vinegar: 0.25 cup","demerara sugar: 0.25 cup","fresh rosemary: 1.5 tbsp","butter: 2.0 tbsp","whole grain mustard: 2.0 tbsp","Salt and pepper to taste: 2.0 servings"}	45
655771	https://spoonacular.com/recipeImages/655771-312x231.jpg	jpg	0	4	{"lamb stew meat",onion,rhubarb,turmeric}	Persian Rhubarb Stew (Khoresh Rivas)	{"In a pan, heat 2-3 tablespoons of oil and saute chopped onions until translucent.","Add turmeric, stir, add the meat and brown on all sides.","Add salt and pepper to taste.","Pour enough water to cover the meat. Cover and cook for an hour on medium to low heat, longer if it is not yet tender.In a medium-sized frying pan, saute the chopped parsley and mint together in 2 tablespoons of oil over medium heat.","Combine the parsley and mint mixture with the meat sauce half way through the cooking.","Add water if necessary.Lightly saute sliced rhubarbs in 2 tablespoons of olive oil for 2-3 minutes on medium heat.","Add the rhubarb to the pot, lower the heat to a gentle simmer and cook for an additional 15 minutes.Taste and add 2-3 tablespoons of sugar or to taste, gently stir and cook for an additional 5 minutes.","Serve warm with basmati rice."}	{"lamb stew meat: 1.5 pounds","Oil: 2.0 tbsp","onion chopped: 1.0 small","rhubarb: 8.0 stalks","Salt and pepper to taste: 6.0 servings","sugar or to taste: 3.0 tablespoons","turmeric: 0.5 teaspoon","Water: 6.0 servings"}	45
636366	https://spoonacular.com/recipeImages/636366-312x231.jpg	jpg	0	6	{"brussels sprouts",eggs,butter,garlic,"chilly flakes","little water/ milk"}	Brussels Sprouts With Salted Eggs	{"Mash 2 salted egg yolks + one egg white together. (Using all 2 egg whites would make it too salty)","Heat butter and grapeseed oil in a pan and stir in chopped garlic. Give it a quick stir without over-browning.","Add mashed salted eggs. Stir fry for a little bit then add in brussels sprouts.","Stir to combine. If it looks a little dry, add in some water or milk and cook until sprouts turn a slight translucent color.... or if you like them crunchy, cook a shorter time.","Add a little sugar to taste and stir in chilly flakes.","Serve hot with fluffy white rice."}	{"brussels sprouts, quartered (I had about full cup after quartering them, you can just halve them if th: 1.0 ","salted eggs, boiled and shelled: 2.0 ","butter: 1.0 tablespoon","grapeseed oil (this is just to prevent the butter from browning too quickly): 1.0 tablespoon","chopped garlic: 1.0 tablespoon","sugar: 1.0 pinch","pinch chilly flakes: 1.0 pinch","a little water/ milk: 1.0 serving"}	45
658134	https://spoonacular.com/recipeImages/658134-312x231.jpg	jpg	0	3	{croissant,"corned beef hash",egg}	Redneck Breakfast on a Croissant	{"Split the croissant in half and toast.","Heat a non stick pan over medium high heat, add the corned beef hash.  Cook the has until it is brown and crisp on one side (3 to 5 minutes), then flip with a turner and cook the other side until it is crisps and browns, another 3 to 5 minutes.  Note: While cooking the has push it together and flatten it so it makes a little patty, its much easier to flip and serve that way.","Place the corned beef hash patty on the bottom half of the toasted croissant.","In the same pan, melt the butter and add the egg, fry according to taste.","Sprinkle the egg with a little salt and pepper and place on top of the corned beef hash patty.  On the top side of the croissant, squeeze a layer of canned cheese over it.","Place the top layer over the bottom half.","Serve immediately."}	{"croissant: 1.0 ","canned corned beef hash: 0.25 cup","egg: 1.0 ","butter: 0.5 teaspoon","Kosher salt and freshly ground black pepper: 1.0 serving"}	45
665352	https://spoonacular.com/recipeImages/665352-312x231.jpg	jpg	0	5	{"apple juice","cedar plank","garlic cloves","salmon filet","bourbon whiskey"}	Wildwood Ovens Bourbon Apple Glazed Cedar Plank Salmon	{"Soak cedar plank in water for 2 hours.  Rinse salmon under cold water and pat dry with paper towels.","Place a medium sauce pan over medium high heat and add bourbon or brandy.  Use caution as the alcohol can ignite; never pour directly from the bottle.   When alcohol is reduced and there is only a small amount left, add apple juice, brown sugar, and garlic.  Continue to cook over medium high heat until reduced to about  of the original volume (should be slightly thinner than syrup).Season salmon with salt and pepper on both sides, brush skin side with olive oil and place on cedar plank, skin side down.","Place cedar plank on a medium high grill, or in a wood fired oven pre-heated to 500F near the fire.  Use a probe thermometer to check the internal temperature of the salmon after 10 minutes, and every 5 minutes or so thereafter.  Once the salmon has an internal temperature of at least 100F, brush on the apple glaze that you made earlier, repeat this step every few minutes. Cook salmon until"}	{"Apple Juice: 1.0 cup","Brown Sugar: 0.25 cup","Cedar Plank: 1.0 ","Garlic Cloves (minced): 2.0 ","T Kosher salt: 1.0 T","T Fresh cracked black pepper: 1.0 T","Salmon Filet: 2.0 pounds","Bourbon Whiskey, or Brandy: 0.25 cup"}	45
645418	https://spoonacular.com/recipeImages/645418-312x231.jpg	jpg	0	5	{"green beans","pearl onions",butter,"chicken stock","salmon steaks"}	Green Beans with Pearl Onions and Salmon	{"In a large pot add some water the frozen beans and frozen pearl onions. Cover and cook over medium heat until they are tender.","Drain and set aside.","In a large skillet over medium high heat melt 1 tablespoon of butter and the olive oil.","Add the green beans and pearl onions and saut for 1 minute.","Add the chicken stock and cook for another minute until the stock is evaporated.","Add 1 tablespoon of butter and the brown sugar; lower the heat to low and mix gently until slightly caramelized.","Remove from the heat and keep warm.","Return the skillet back to medium high heat and melt the remaining  teaspoon of butter in the center, add the salmon over and season with Slavosalt generously. Cook for 3-5 minutes until a golden crust is formed. Turn and cook for another 3 minutes.","Place the green beans with pearl onions on the plate and top with the salmon."}	{"frozen green beans: 1.0 pound","frozen pearl onions: 1.0 cup","olive oil: 1.0 teaspoon","unsalted butter + ½ teaspoon: 2.0 tablespoon","chicken stock, sodium free: 0.25 cup","brown sugar: 1.0 teaspoon","Slavosalt seasoning – or salt and pepper: 4.0 servings","Salmon steaks, skinless: 4.0 servings"}	45
639637	https://spoonacular.com/recipeImages/639637-312x231.jpg	jpg	0	3	{milk,"strawberry jam and cream",butter}	Classic scones	{"Using fingertips, rub butter into flour until mixture resembles fine breadcrumbs.Make a well in the centre of the dry ingredients and add milk, stirring with a metal spatula or butter knife until mixture comes away from the sides of the bowl. If mixture is dry, add a little extra milk.Turn mixture onto a lightly floured bench and bring the dough together until a rough ball of dough is formed. Do not over-knead. Pat dough to 2 cm thickness. With a clean knife, quarter the dough or use a round cutter to cut rounds.Arrange scones onto a baking paper lined tray and bake at 220C for 12-15 minutes until golden and they sound hollow when lightly tapped on the base.","Serve scones straight from the oven with jam and cream."}	{"milk: 0.75 cup","self raising flour: 2.0 cups","strawberry jam and cream, for serving: 4.0 servings","unsalted butter, softened: 50.0 g"}	45
994607	https://spoonacular.com/recipeImages/994607-312x231.jpg	jpg	0	3	{eggs,milk,butter}	Kaiserschmarrn	{"Separate eggs, yolks and whites each in a big bowl.","Put sugar, vanilla sugar, and salt in the bowl with the yolk and mix well.","Add 1 tablespoon of flour and a big sip of milk to the yolk mixture and stir well. Repeat this until all the flour and milk are blended in.","Clarify the butter in a large pan on low heat.","Beat the egg whites stiff.","Add the clarified butter to the egg yolk mixture.","Carefully lift the stiff egg whites under the egg yolk mixture until there are no chunks left. Do this carefully to not lose all the air, the mixture needs to stay fluffy.","Pour mixture into a preheated pan on medium heat. The pan size should be so big that when all the dough is in the pan, it is about 1cm thick.","Cook on low to medium heat for about 5-10 minutes. Then quarter the pancake and flip the pieces over. Wait another 3 to 5 minutes and then start chunking the dough into bite sized pieces while letting them crisp up in the pan.1","Add powder sugar and or apple sauce or any other sauce that you like."}	{"eggs: 5.0 small","milk (3.5% fat): 375.0 ml","salt: 1.0 dash","unsalted butter: 37.0 g","vanilla sugar: 8.0 g","white flour: 190.0 g","white sugar: 1.0 Tbsp"}	50
660697	https://spoonacular.com/recipeImages/660697-312x231.jpg	jpg	0	3	{"dressed catfish","garlic powder",cornmeal}	Southern Fried Catfish	{"Combine flour, cornmeal, garlic powder and salt. Coat catfish with mixture, shaking off excess. Fill deep pot or 12-inch skillet half full with oil.","Heat to 350 degrees.","Add catfish in a single layer, and fry until golden brown, 5 to 6 minutes, depending on size.","Remove and drain on paper towels."}	{"catfish fillets or whole dressed catfish: 4.0 ","flour: 0.25 cup","Garlic Powder: 0.125 teaspoon","Salt: 2.5 teaspoons","Vegetable oil: 6.0 servings","yellow cornmeal: 0.75 cup"}	45
654566	https://spoonacular.com/recipeImages/654566-312x231.jpg	jpg	0	4	{shrimp,panko,eggs,lemon}	Panko Shrimp	{"Soy sauce for dipping","Peel and devein shrimp,but leave tails attached.Wash well in salted water until water runs clear.This will be 5 or 6 changes of water.Dry on paper towels. Beat eggs in a bowl.","Pour flour and panko onto separate pieces of waxed paper. Holding a shrimp by the tail,roll it in the flour,egg and panko.","Place on cookie sheet.Repeat with remaining shrimp.This may be done several hours in advance,but keep them in the refrigerator.","Heat oil in a pan to 350 degrees.Deep-fry shrimp until they turn light golden brown.You may need to do this in several batches,because if you crowd out the pan,they will not brown properly.","Drain on paper towels.",Cut,"Note:The Japanese eat a lot of foods at room temperature and fried food coated with panko stays crisp for several hours,hence it is good picnic food.This dish is served as an appetizer course in a Japanese meal but would also make a good hors d'oeuvre at a Western-style party."}	{"Shrimp (26 to 30): 1.0 pound","Panko (Japanese breadcrumbs): 2.0 cups","Flour: 1.0 cup","Eggs: 2.0 ","Oil for frying: 6.0 servings","Lemon: 1.0 "}	45
631849	https://spoonacular.com/recipeImages/631849-312x231.jpg	jpg	0	4	{"cocoa powder",egg,milk,vanilla}	2 Minute Chocolate Yum	{"Roughly will be enough batter for two smaller 6-8 oz. ramekins (just fill a little over  full)In a small mixing bowl whip the ingredients together until smooth. Cook one at a time in the microwave for 2-minutes or until the cake is puffed up.","Serve immediately with a scoop if ice-cream or a dollop of whipped topping, or as we did with just a sprinkle of powder sugar/cocoa powder mixture.Another great idea to change this up would be to make mini black forest cakes, put half of the batter in the bottom and top with a small spoonful of cherry pie filling then top with the rest of the batter and cook."}	{"Cocoa Powder: 2.0 tablespoons","Egg, slightly beaten: 1.0 ","Flour: 0.25 cup","milk: 100.0 ml","Oil: 3.0 tablespoons","Salt: 1.0 Dash","Sugar: 5.0 tablespoons","vanilla: 1.0 teaspoon"}	45
634891	https://spoonacular.com/recipeImages/634891-312x231.jpg	jpg	0	5	{"style bread crumbs","chicken cutlets",eggs,"mozzarella cheese","parmesan cheese"}	Best Chicken Parmesan	{"Depending on how think your chicken breasts are, place them under plastic wrap and pound until thin. If you don't have a meat pounder, use a heavy pot of skillet. You can also fillet these with a knife.Get 3 pie plates or containers. Put flour in one, beaten eggs in one and bread crumbs in one.Dredge chicken breast in flour, then in the egg wash, and then the bread crumbs.Fry cutlets in vegetable oil over med heat. Fry until golden brown.","Spread a little marinara on the bottom of a 13x9 baking dish.Make a layer of chicken.","Add more marinara. Use most of the first quart.","Add a layer of the cheeses. Repeat layers.","Sprinkle parsley over last layer of cheese.","Bake in a pre-heated 350 degree oven covered for 35 minutes. uncover and bake until top is bubbly!"}	{"Italian style bread crumbs: 2.0 cups","each) chicken cutlets: 24.0 ounces","eggs beaten: 3.0 ","Flour: 1.0 cup","mozzarella cheese (depending on how much cheese you like): 4.0 cups","Parmesan cheese (Grated fresh, not from a green can): 0.5 cup","vegetable oil for frying (you bake them too, but they're better fried!): 1.0 can"}	45
635778	https://spoonacular.com/recipeImages/635778-312x231.jpg	jpg	0	3	{boysenberries,honey,"white wine vinegar"}	Boysenberry Syrup	{"Place the boysenberries in a glass or china bowl and pour the vinegar over.Leave to stand for at least 24 hours, stirring and pressing the fruit regularly, to extract the juices. Strain the liquid into a large saucepan or small preserving pan and bring to the boil.","Add the sugar, stirring until it is all dissolved, then add the honey, stirring well. Bring back to the boil and boil hard for 5 minutes. Allow to cool completely. Originally this syrup was bottled and stored, one tablespoon beiA pleasant nightcap that is also said to be good for reliving a cold."}	{"Boysenberries: 1.0 pound","Honey: 4.0 ounces","sugar or less: 1.0 cup","White wine vinegar: 2.0 pints"}	45
654274	https://spoonacular.com/recipeImages/654274-312x231.jpg	jpg	0	2	{"steel cut oats",fruit}	Overnight Steel Cut Oatmeal	{"Stir all ingredients together in a slow cooker. Cover and cook on low for 8 hours overnight. In the morning, stir well and add milk, spices, or additional toppings to your liking."}	{"dry steel cut oats: 2.0 cups","water: 8.0 cups","dried fruit: 0.75 cup","butter: 2.0 tablespoons"}	45
654485	https://spoonacular.com/recipeImages/654485-312x231.jpg	jpg	0	3	{"add-ins - i used of bacon fbatch of 12 pancake bites","maple syrup","pancake batter"}	Pancake Bites	{"Preheat oven to 350 degrees f. Spray a mini-muffin tin lightly with cooking spray. Toss the add-ins with a small spoonful of dry pancake mix or flour, to keep them from sinking to the bottom of the muffin tins.Spoon batter into each muffin cup about 1/2 full.","Sprinkle with a little of the add-in of your choice (or you can just make them plain, of course). Top with a bit more batter, filling the muffin tins about 3/4 of the way full.","Bake for about 12 minutes, until cooked through.","Remove from the muffin tins and brush lightly with butter. Repeat with remaining batter.","Serve warm with maple syrup."}	{"add-ins - I used of crumbled bacon fbatch of 12 pancake bites, and fresh blueberries for another, adding 3 fresh blueberries to each muffin cup: 4.0 slices","Butter: 0.5 cup","maple syrup: 0.75 cup","prepared pancake batter: 3.5 c"}	45
716407	https://spoonacular.com/recipeImages/716407-312x231.jpg	jpg	0	3	{eggs,"maple syrup",milk}	Simple Whole Wheat Crepes	{"Place all ingredients in a blender and mix until smooth. The batter should be thin.","Let it sit at least 30 minutes—or even overnight.When it comes time to cook your crêpes you can do it the traditional way, in a crêpe pan, or you can use an electric crêpe maker."}	{"butter, melted: 3.0 Tablespoons","eggs: 3.0 ","maple syrup (optional): 1.0 Tablespoon","milk: 1.0 cup","pinch of sea salt: 1.0 pinch","white whole wheat flour: 1.0 cup"}	45
643241	https://spoonacular.com/recipeImages/643241-312x231.jpg	jpg	0	7	{blackberries,blueberries,"lemonade concentrate",raspberries,strawberries,"vanilla extract",milk}	Four-Berry Blast Fruit Smoothie	{"Place first five items into a blender and pulse a few times.","Add the next berry and pulse 2-3 times. Repeat until all berries have been added, then blend on high until smooth."}	{"frozen blackberries: 0.5 cup","frozen blueberries: 0.5 cup","lemonade concentrate: 2.0 tablespoons","frozen unsweetened raspberries: 0.5 cup","frozen unsweetened strawberries: 0.5 cup","sugar: 1.0 tablespoon","vanilla extract: 0.5 teaspoon","whole milk (do not use skim): 5.5 cups"}	10
647555	https://spoonacular.com/recipeImages/647555-312x231.jpg	jpg	0	5	{"baking powder",egg,milk,"vanilla extract","food coloring"}	Hotcakes	{"Stir the flour, sugar, and baking powder in a large bowl until mixed.In another bowl, beat the milk, melted butter, egg, vanilla, and food coloring until blended.","Pour the wet ingredients into the dry ingredients and beat until just blended (it's better to leave a few lumps than to overmix and make tough hotcakes). The hotcakes will be lighter if you let this batter stand at room temperature for about 30 minutes, or refrigerate it up to 1 day.","Heat a griddle or large heavy pan (cast iron is perfect) over medium heat. The griddle is hot enough when a drop of water skitters quickly across the surface.","Brush the griddle with a little melted butter.","Pour about 1/3 cup of batter for each hotcake, leaving a little space between the hotcakes to make it easy to turn them. Cook them until golden brown underneath (lift a corner to peek) and bubbles start to pop on the topsides. Flip the hotcakes carefully and cook them until the undersides are golden brown. Repeat with the rest of the batter.","Serve hot with butter and maple syrup."}	{"Baking powder: 2.0 tablespoons","Egg: 1.0 large","All-purpose flour: 4.0 cups","Milk: 2.0 cups","sugar: 1.0 tablespoon","Unsalted butter -- melted: 8.0 tablespoons","Vanilla extract: 2.0 teaspoons","Yellow food coloring: 0.5 teaspoon"}	45
643249	https://spoonacular.com/recipeImages/643249-312x231.jpg	jpg	0	3	{"starter at room temp",egg,"baking soda"}	Fourth Of July Sourdough Pancakes	{"In a bowl, whisk together the starter, sugar, egg, oil, and salt; set aside.","Heat up a cast iron skillet or non-stick pan on medium heat","When ready to make; mix baking soda & water, add to the batter","Scoop a ladle full of batter onto the pan,","Wait about 30-45 seconds till it bubbles up and starts to set on the bottom,","Then flip and wait another 30-45 seconds","Keep going till all the batter is gone",Viola!}	{"sour starter at room temp: 2.0 cups","cane sugar: 2.0 tablespoons","egg: 1.0 ","olive oil, or any vegetable oil: 4.0 tablespoons","salt: 0.5 teaspoon","baking soda: 1.0 teaspoon","warm water: 1.0 tablespoon"}	45
657359	https://spoonacular.com/recipeImages/657359-312x231.jpg	jpg	0	5	{pumpkin,cinnamon,"ground nutmeg","soy milk","vanilla protein powder"}	Pumpkin Pie Smoothie	{"Add all ingredients to the blender in order of the listed ingredients.","Blend until perfect consistency is achieved."}	{"brown sugar: 1.0 tablespoon","canned pumpkin: 1.0 cup","cinnamon: 1.0 teaspoon","ground nutmeg: 0.25 teaspoon","ice: 6.0 cubes","soy milk (or dairy milk): 1.0 cup","vanilla protein powder: 0.5 scoop"}	5
652952	https://spoonacular.com/recipeImages/652952-312x231.jpg	jpg	-1	3	{eggs,milk,"x10 puff pastry"}	Napoleon - A Creamy Puff Pastry Cake	{"First prepare the dough. Depending on the manufacturer of the puff pastry, you might need to defrost the dough, and either roll out or cut the sheets to the desired size.Preheat the oven to 400F. Line 2 cookie sheets with parchment paper.","Bake each puff pastry sheet for 20 minutes on the middle rack. After 10 minutes you might want to rotate the cookie sheet 180 degrees to ensure equal baking. When the pastry is puffed and light golden brown it is ready.","Let the puff pastry cool, and then cut each sheet horizontally into 2 layers, basically making 4 thin sheets. You will need 3 of them for the actual sheets and 1 for decorative crumbs, which you can easily make with your fingers.Now for the cream: Beat the eggs with the sugar and flour. Boil the milk. While the milk is warming, pour about 1/2 cup into the egg mix and stir well to gradually increase its temperature. This way the eggs wont curdle when you add them to boiling milk. Repeat this step 2-3 more times as the milk approaches boiling temperature.Once the milk boils, pour the warm egg mix into the boiling milk, constantly stirring, to prevent lumps from forming. Keep on the stove for several 3 more minutes, continue stirring. Its best to use hand held mixer in this stage.","Remove the cream from heat, let cool, and spread on the puff pastry sheets, creating alternating layers of puff pastry and cream (3 layers of each type, 6 total).","Spread the pastry puff crumbs on top of the upper cream layer.Refrigerate for 2-3 hours or overnight before serving."}	{"Hard cooked eggs: 6.0 ","flour: 1.0 cup","milk: 0.25 gallon","10''x10'' (25cm x 25cm) puff pastry sheets: 2.0 sheets","sugar: 1.0 cup"}	45
1095713	https://spoonacular.com/recipeImages/1095713-312x231.jpg	jpg	0	4	{"baking soda","coco treasure organics coconut flour","vanilla extract",eggs}	Coconut Flour Muffins	{"Preheat the oven to 350 degrees Fahrenheit.","Mix the dry ingredients in a small bowl. Set aside.","In a separate bowl, mix coconut oil, coconut nectar syrup, pure vanilla extract, and beaten eggs.","Slowly add the dry ingredients.","Mix until well blended.","Leave for 5 minutes to let the flour absorb the liquid. While waiting, grease a muffin pan.","Scoop the muffin batter into the pan. Fill it until it is  full.","Bake for 30 minutes.","Let the muffins cool before taking out of the pan.",Serve.}	{"sea salt: 0.25 teaspoon","baking soda: 0.5 teaspoon","Coco Treasure Organics Extra Virgin Coconut Oil melted: 0.5 cup","Coco Treasure Organics Coconut Nectar Syrup: 0.5 cup","Coco Treasure Organics Coconut Flour: 0.75 cup","pure vanilla extract: 1.0 teaspoon","eggs: 6.0 pieces"}	45
637705	https://spoonacular.com/recipeImages/637705-312x231.jpg	jpg	0	6	{"non-fat yogurt","agave syrup","vanilla extract",cherries,"rolled oats","cocoa powder"}	Cherries and Yogurt Parfait	{"In a large bowl combine the yogurt, honey, and vanilla; mix well and set aside.","Mix the oats and the cocoa together and pour in a skillet.","Toast the oats over medium heat for about 8 minutes, stirring occasionally. Cool completely and set aside.","Put the pitted cherries in the skillet and cook for about 10 minutes, or until soft. Cool completely.","Assemble the parfaits by pouring a 1/2 cup of yogurt in each glass.","Spoon over some of the oats, top with half of the cherries, then pour the rest of the yogurt on top, and finish off with more oats and cherries.","Put the parfaits in the fridge for a couple of hours before serving.","I partially froze mine and pretended that I was eating ice cream with the rest. In fact, I urge you to freeze it because it is that much better when frozen."}	{"non-fat plain yogurt: 2.0 cups","honey or agave syrup: 3.0 tablespoons","pure vanilla extract: 1.5 teaspoons","pitted cherries: 2.0 cups","rolled oats: 0.25 cup","cocoa powder: 1.0 teaspoon","sugar: 0.5 teaspoon"}	45
639477	https://spoonacular.com/recipeImages/639477-312x231.jpg	jpg	0	5	{cinnamon,milk,"rolled oats",applesauce,"vanilla extract"}	Cinnamon Roll Oatmeal	{"Preheat oven to 375 F.","Combine all ingredient for the oatmeal and mix together very well. Set aside.In a separate bowl mix together all ingredients for cinnamon swirl.","Pour half of the oatmeal mixture in a ramekin. Scoop half of the cinnamon mixture on top of it and swirl it through the oatmeal with a toothpick.","Pour remaining half of oatmeal on top and spoon remain cinnamon mixture on top in a swirl pattern.","Bake for 20 minutes. Than broil for 3-5 minutes (until edges start to brown)."}	{"cinnamon: 5.0 teaspoons","coconut oil (melted): 1.0 tbsp","coconut sugar: 1.5 tbsp","milk: 0.25 cup","gluten free rolled oats: 0.5 cup","sea salt: 0.125 tsp","unsweetened applesauce: 0.25 cup","vanilla extract: 0.5 tsp"}	45
644914	https://spoonacular.com/recipeImages/644914-312x231.jpg	jpg	0	6	{"baking powder",egg,"evaporated milk","poppy fix",raisins,"glutinous rice flour"}	Glutinous Rice Poppy Muffins	{"Stir together the evaporated milk, egg, oil and sugar in a mixing bowl. Sift in glutinuous rice flour and baking powder and blend thoroughly.Divide half of the rice batter into 8-10 paper muffin liners, spoon in some poppy fix and add in a few of raisins. Finally cover with the rest of rice batter.","Sprinkle with some poppy seeds.","Bake in a preheated 190C/375F oven for about 30 minutes. Take out the muffins and brush the tops with a thin layer of oil. Return to the oven and continue to bake for another 10 minutes."}	{"Baking powder: 1.0 teaspoon","egg: 1.0 large","Evaporated milk: 200.0 grams","Poppy fix: 100.0 grams","Some poppy seeds: 10.0 servings","Raisins: 30.0 grams","Glutinous rice flour: 200.0 grams","Sunflower oil: 1.0 tablespoon","White sugar: 60.0 grams"}	45
633399	https://spoonacular.com/recipeImages/633399-312x231.jpg	jpg	0	6	{bananas,"browned butter","creme fraiche",eggs,"baileys irish cream",milk}	Bailey's Irish Cream Crepes With Creme	{"Brown your butter by adding slices of butter to a heavy bottomed saucepan. One melted, whisk it frequently until you see small brown specks begin to form at the bottom of the pan. The butter should have a nutty aroma.","Remove it from the pan to prevent further cooking.","Mix the browned butter with the flour, salt, sugar, eggs, milk and Bailey's. Using an immersion blender, blend the mixture until completely smooth.","Let the mixture rest for 1/2 hour.Butter a non-stick frying pan and heat over medium heat. Using a ladle, spoon in the batter and quickly pick up the pan and swish it around so that the entire pan bottom is covered with a very thin layer of batter.When the underside is golden, use your fingers or a spatula to flip the crepe over to cook the other side.","Serve with sliced bananas, creme fraiche (or sour cream) and brown sugar. We also had Dulce de Leche on the table!"}	{"sliced bananas: 4.0 servings","brown sugar: 4.0 servings","(a bit less than 5 tablespoons) browned butter: 70.0 grams","creme fraiche (or sour cream): 4.0 servings","eggs: 2.0 ","(a bit less than ½ cup) Bailey's Irish Cream (or milk, if you prefer): 100.0 milliliters","250 milliliters milk: 1.0 cup","salt: 1.0 teaspoon","sugar: 0.25 cup"}	45
1096274	https://spoonacular.com/recipeImages/1096274-312x231.jpg	jpg	-1	3	{"whipping cream",milk,"vanilla extract"}	Very Vanilla Egg-Free Ice Cream	{"Place all ingredients in a bowl.","Whisk until a layer of bubbles forms on the surface and the sugar is dissolved.","Pour the mixture into the canister of the ice cream maker and churn according to manufacturer's directions."}	{"whipping cream: 2.0 cups","whole milk: 1.0 cup","sugar: 0.5 cup","vanilla extract: 1.5 tablespoons"}	45
663853	https://spoonacular.com/recipeImages/663853-312x231.jpg	jpg	0	9	{quinoa,"coconut milk",pineapple,cinnamon,"maple syrup",coconut,pecans,strawberries,"balsamic vinegar"}	Tropical Breakfast Quinoa	{"In a medium size pot combine cooked quinoa, coconut milk, crushed pineapple, cinnamon and maple syrup; stir to combine. Bring to a boil and reduce heat. Cook for 5 minutes, stirring occasionally.","Top quinoa mixture with toasted coconut, pecans, sliced strawberries and balsamic vinegar."}	{"cooked quinoa: 1.0 cup","light coconut milk: 0.5 cup","crushed pineapple: 3.0 tablespoons","cinnamon: 0.25 teaspoon","maple syrup: 1.0 teaspoon","toasted coconut: 2.0 tablespoons","pecans: 5.0 ","sliced strawberries: 0.5 cup","balsamic vinegar: 1.0 teaspoon"}	45
664054	https://spoonacular.com/recipeImages/664054-312x231.jpg	jpg	0	6	{"baby portabella mushrooms","diestel breakfast sausage","rainbow chard",eggs,"green onion","sweet potato"}	Turkey Sausage, Chard & Sweet Potato Breakfast Scramble	{"In a medium-sized skillet, heat about two teaspoons of olive oil on medium heat.","Add the chopped sweet potato and saut 3 or 4 minutes before adding a little liquid and covering. In about 2 minutes, check to see if the liquid has burned off. If it has, add a little more and cover again. Repeat this several times until the sweet potato is soften, but still al dente.","Add the mushrooms and the chopped chard stems. Saut another 3 to 5 minutes and add additional liquid if necessary.Move the veggies to one side of the skillet with a wooden spoon and add the ground breakfast sausage. Brown the meat and using the wooden spoon break it apart. Continue sauting until the sausage is cooked all the way through.Immediately add the green onion and chard leaves. Allow to steam for about 30 seconds before pouring the scrambled egg mixture evenly over the meat and veggies. This is where the technique comes in. Avoid the temptation to stir. Simply allow the skillet to sit 2 to three minutes. Then, using a wooden spoon or spatula, begin flipping sections of egg and veggies (similar to how you would fold whipped egg whites into a cake batter, just gently fold the scramble onto itself). Once all sections have been flipped over, everything to sit and cook another 2 or 3 minutes. Repeat the flipping.  Continue doing this until the egg is no longer cooking to the skillet.","Serve with your favorite toppings!"}	{"baby portabella mushrooms, coarsely chopped: 3.0 ","Diestel Breakfast Sausage: 6.0 ounces","rainbow chard, stems removed and chopped, leaves chopped: 2.0 stalks","eggs: 6.0 ","green onion, chopped: 2.0 stalks","olive oil: 2.0 teaspoons","sweet potato: 0.5 ","water: 0.25 cup"}	45
640194	https://spoonacular.com/recipeImages/640194-312x231.jpg	jpg	0	11	{"tofu and veggie scramble",mushrooms,asparagus,onions,"garlic clove",seasonings,tumeric,"garlic powder","cayenne pepper","home fries",potatoes}	Country Breakfast: Tofu and Veggie Scramble With Home Fries	{"Tofu and veggie scramble","Press the tofu for 30 minutes prior to cooking. Chop all the veggies and leave ready to begin cooking process.","Using a non-stick skillet, heat olive oil on medium heat.","Add pressed tofu and crumble in large pieces. The tofu will need to cook and dry out a little for 10 to 15 minutes, so meanwhile, add onions and garlic to tofu.","After those 15 minutes, add asparagus and mushroom and all the rest of the spices plus the water. Cook for 5 minutes and serve hot!","Home Fries","Prepare potatoes before starting on tofu scramble.","Preheat oven to 450F and move oven rack to the next to last highest row. Line a small cookie sheet with parchment paper.","Wash and scrub potatoes. Dice them and add to a medium bowl.","Add olive oil, salt and pepper and mix well.","Pour potatoes on cookie sheet and spread evenly.","Bake for 20 minutes and serve while hot."}	{"Tofu and Veggie Scramble: 2.0 servings","box Mori-Nu tofu: 12.0 ounces","olive oil: 1.0 tablespoon","sliced mushrooms: 1.0 cup","asparagus, chopped: 1.0 cup","onions, chopped: 0.5 cup","garlic clove, minced: 1.0 ","Italian seasonings: 1.5 teaspoons","tumeric: 1.5 teaspoons","garlic powder: 0.5 teaspoon","cayenne pepper: 0.5 teaspoon","crushed black pepper: 0.5 teaspoon","water: 2.0 tablespoons","Home Fries: 2.0 servings","red potatoes, diced ½ thick: 3.0 inches","crushed black pepper: 2.0 teaspoons","salt: 1.5 teaspoons","olive oil: 2.0 tablespoons"}	45
1017374	https://spoonacular.com/recipeImages/1017374-312x231.jpg	jpg	0	7	{"bell pepper",eggs,milk,"sm onion","potato tots",cheese,turkey}	Easy Weekday Breakfast Muffins	{"Heat oven to 35","Whisk eggs together in a medium bowl.","Add chopped pepper and onion, salt and pepper, cheese, and milk. Fill muffin tin halfway with egg mixture.","Sprinkle turkey meat into each.","Add a potato tot to each. Top with cheese.","Place in oven for 20 minutes or until fully cooked.","Serve immediately or store for later."}	{"bell pepper chopped: 1.0 ","eggs: 12.0 ","milk: 0.5 cup","sm onion chopped: 1.0 ","potato tots: 12.0 ","salt and pepper to taste: 12.0 servings","cheese shredded: 1.0 cup","turkey chopped: 0.5 cup"}	30
640636	https://spoonacular.com/recipeImages/640636-312x231.jpg	jpg	0	13	{arugula,baguette,basil,butter,"canned tomatoes",pepper,eggs,"garlic cloves",onion,"parmesan cheese","parmesan cheese",rosemary,thyme}	Creamy Egg Marinara Breakfast Dip	{"Place tomatoes, butter, onion, rosemary, thyme, and salt in a saucepan over medium heat.Bring to simmer.Reduce heat to low and continue simmering for 45 minutes.Stir occasionally.","Remove from heat and take out the onion, and sprigs of rosemary and thyme.Seth doesnt like chunks of tomato, so we use an immersion blender to puree the sauce.","Heat oven to 350.In a baking dish, layer the arugula and place the slices of garlic over the arugula.Put half the sauce over that.Break the eggs into the sauce.Cover with remaining sauce.","Sprinkle with parmesan cheese.","Brush the olive oil on baguette slices.","Sprinkle the salt, freshly ground black pepper, and Parmesan cheese.","Bake at 350 for 10 minutes."}	{"arugula: 2.0 cups","baguette, sliced: 1.0 ","chopped basil: 0.25 cup","butter: 5.0 tablespoons","whole peeled tomatoes in juice: 28.0 ounce","crushed red pepper: 0.25 teaspoon","eggs: 7.0 ","garlic cloves, sliced: 2.0 ","olive oil: 0.25 cup","onion, peeled and cut in half: 1.0 ","grated Parmesan cheese: 0.25 cup","Parmesan cheese: 2.0 tablespoons","rosemary: 1.0 small sprig","salt and freshly ground black pepper: 4.0 servings","salt and freshly ground black pepper, to taste: 4.0 servings","thyme: 2.0 sprigs"}	90
632614	https://spoonacular.com/recipeImages/632614-312x231.jpg	jpg	0	14	{"almond meal","baking powder","baking soda",cinnamon,nutmeg,"tablespoons butter",eggs,cream,"daves vanilla and coffee syrup","lemon zest",apple,cherries,pear,"blanched almonds"}	Apple, Cherry, Pear and Almond Breakfast Muffins	{"Preheat oven to 350 degrees","Line 12 cup muffin tin with liners and spray with baking spray.  Line a tray with almond slices and sit in oven for 4-5 minutes until almonds are just starting to toast, but not brown.","Remove pan and let cool.","Place flour, almond meal, baking powder, baking soda, cinnamon, nutmeg, and salt in a bowl and mix well to combine.  Set aside","In a mixer beat 1/2 cup of the butter and sugar until creamed.","Add one egg at a time until mixed.  Scrape down sides of mixer and add sour cream, zest and vanilla blend.","Add flour ingredients and mix until just blended (do not over-mix)","Remove bowl from mixer and by hand add apple and cherries, mixing.","Spoon mixture into each cup filling about 2/3 of the way.","In a small bowl combine, pear, brown sugar, 2 tablespoons of butter and almonds and combine.","Place on top of each muffin.","Bake for 25-30 minutes or until the center of a muffin comes out clean."}	{"sef-rising flour: 1.25 cup","almond meal: 0.5 cup","baking powder: 1.5 teaspoon","baking soda: 0.25 teaspoon","cinnamon: 1.5 teaspoon","nutmeg: 0.25 teaspoon","salt: 0.25 teaspoon","2 tablespoons unsalted butter, room temperature: 0.5 cup","granulated sugar: 0.5 cup","eggs, room temperature: 2.0 large","sour cream or plain yogurt (I used light sour cream): 0.75 cup","vanilla extract or DAVE's vanilla and coffee syrup: 2.0 teaspoon","zest from 1/2 lemon: 1.0 tablespoon","apple, peeled, cored, cut into 1/4″ dice: 1.0 ","dried cherries: 0.5 cup","pear, peeled, cored,cut into 1/4″ dice: 1.0 ","light brown sugar: 2.0 tablespoon","sliced blanched almonds: 0.25 cup"}	45
1697715	https://spoonacular.com/recipeImages/1697715-312x231.jpg	jpg	0	5	{eggs,butter,"heavy cream","pecorino romano",chives}	Shirred Eggs - My Favorite Breakfast Mini-Meal with Maximum Flavor and Minimal Effort	{"Preheat toaster oven to 350℉.","Butter the dish and add the heavy cream. Crack an egg into it and make sure the yolk doesn’t touch the sides.","Sprinkle cheese and chives on top, add salt and pepper and put into toaster oven.","When the white just barely sets, about 15 minutes, remove from oven (warning: ramekins will be hot).","Serve &amp; enjoy!"}	{"eggs: 2.0 large","butter: 0.5 Tbsp","heavy cream: 1.0 Tbsp","Pecorino Romano: 2.0 Tbsp","chives, chopped: 1.0 Tbsp","Salt & pepper: 2.0 servings"}	20
641185	https://spoonacular.com/recipeImages/641185-312x231.jpg	jpg	0	8	{"chicken stock",polenta,bacon,"bell pepper","green onions","turkey sausage",feta,"bell pepper"}	Dad’s Breakfast Polenta	{"Prepare polenta according to package directions. (Be sure to season with some salt and pepper as well!)","Meanwhile, cut bacon into small pieces and brown in a skillet with 1 tablespoon olive oil, on medium-high heat, until brown and crispy.","Remove the bacon and reserve for later.","Depending on your preference, you can either clean the pan and use 1 tablespoon olive oil, or you can cook the remaining veggies with a tablespoon of the bacon fat.)","Add turkey sausage and bell pepper and saut until sausage is browned and cooked through.","Add green onions, bacon, salt and pepper and saut for 5 more minutes.","Add polenta to the meat and vegetables and stir to combine. Slowly stir in feta.","Serve warm."}	{"chicken stock: 3.0 cups","polenta: 1.0 cup","bacon, diced: 4.0 pieces","green bell pepper: 0.5 ","green onions, sliced: 5.0 ","turkey sausage: 4.0 pieces","feta: 0.25 cup","Salt: 4.0 servings","Pepper: 4.0 servings"}	45
633219	https://spoonacular.com/recipeImages/633219-312x231.jpg	jpg	0	10	{"cooking oats","baking powder",cinnamon,egg,"egg white",vanilla,molasses,"you can use store purchased",raisins,apples}	Baby Blake’s Oatmeal Breakfast Cookies	{"Preheat the oven to 350 and spray a non-stick cookie sheet with cooking spray.","Mix dry ingredients including sugar in a large bowl","Make a well in the center of the dry ingredients and add the remaining ingredients EXCEPT raisins and apples.","Mix the wet and dry ingredients together until well blended. Fold in raisins and apples.","Drop by large tablespoonfuls onto the cookie sheet 2 apart.","Bake 8  10 minutes until cookies are nicely browned and cooked through."}	{"flour: 1.0 cup","whole wheat flour: 1.0 cup","quick cooking oats: 3.0 cups","baking powder: 1.0 teaspoon","salt: 0.5 teaspoon","cinnamon: 1.0 teaspoon","sugar, I prefer Sugar in the Raw: 1.0 cup","egg, cage free: 1.0 large","egg white, cage free: 1.0 large","vanilla: 2.0 teaspoons","molasses: 2.0 tablespoons","butternut squash – steamed and pureed, or you can use organic store purchased pureed: 1.0 cup","canola oil: 0.25 cup","raisins: 1.0 cup","apples, organic, peeled and diced: 1.0 cup"}	45
\.


--
-- Data for Name: shopping_lists; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.shopping_lists (shopping_list_id, user_id) FROM stdin;
1	1
2	2
3	3
4	4
5	5
6	6
7	7
8	8
9	9
10	10
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.users (user_id, email, password) FROM stdin;
1	user0	test
2	user1	test
3	user2	test
4	user3	test
5	user4	test
6	user5	test
7	user6	test
8	user7	test
9	user8	test
10	user9	test
\.


--
-- Name: fav_recipes_fav_recipe_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.fav_recipes_fav_recipe_id_seq', 127, true);


--
-- Name: ingredients_ingredient_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.ingredients_ingredient_id_seq', 79, true);


--
-- Name: ratings_rating_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.ratings_rating_id_seq', 101, true);


--
-- Name: recipes_recipe_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.recipes_recipe_id_seq', 1, false);


--
-- Name: shopping_lists_shopping_list_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.shopping_lists_shopping_list_id_seq', 10, true);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.users_user_id_seq', 10, true);


--
-- Name: fav_recipes fav_recipes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fav_recipes
    ADD CONSTRAINT fav_recipes_pkey PRIMARY KEY (fav_recipe_id);


--
-- Name: ingredients ingredients_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ingredients
    ADD CONSTRAINT ingredients_pkey PRIMARY KEY (ingredient_id);


--
-- Name: ratings ratings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ratings
    ADD CONSTRAINT ratings_pkey PRIMARY KEY (rating_id);


--
-- Name: recipes recipes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recipes
    ADD CONSTRAINT recipes_pkey PRIMARY KEY (recipe_id);


--
-- Name: shopping_lists shopping_lists_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shopping_lists
    ADD CONSTRAINT shopping_lists_pkey PRIMARY KEY (shopping_list_id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: fav_recipes fav_recipes_recipe_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fav_recipes
    ADD CONSTRAINT fav_recipes_recipe_id_fkey FOREIGN KEY (recipe_id) REFERENCES public.recipes(recipe_id);


--
-- Name: fav_recipes fav_recipes_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fav_recipes
    ADD CONSTRAINT fav_recipes_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: ingredients ingredients_shopping_list_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ingredients
    ADD CONSTRAINT ingredients_shopping_list_id_fkey FOREIGN KEY (shopping_list_id) REFERENCES public.shopping_lists(shopping_list_id);


--
-- Name: ratings ratings_recipe_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ratings
    ADD CONSTRAINT ratings_recipe_id_fkey FOREIGN KEY (recipe_id) REFERENCES public.recipes(recipe_id);


--
-- Name: ratings ratings_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ratings
    ADD CONSTRAINT ratings_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: shopping_lists shopping_lists_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shopping_lists
    ADD CONSTRAINT shopping_lists_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- PostgreSQL database dump complete
--

